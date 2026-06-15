local M = {}

local function normalize(path)
  return vim.fn.fnamemodify(path, ":p"):gsub("/$", "")
end

local function cwd_for_tab(tabpage)
  local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
  local ok, cwd = pcall(vim.fn.getcwd, -1, tabnr)
  return ok and normalize(cwd) or nil
end

local function short_branch(ref)
  if not ref or ref == "" then
    return nil
  end
  return ref:gsub("^refs/heads/", "")
end

local function git_branch(path)
  local escaped = vim.fn.shellescape(path)
  local branch = vim.fn.systemlist("git -C " .. escaped .. " branch --show-current 2>/dev/null")
  if vim.v.shell_error == 0 and branch[1] and branch[1] ~= "" then
    return branch[1]
  end

  local head = vim.fn.systemlist("git -C " .. escaped .. " rev-parse --short HEAD 2>/dev/null")
  if vim.v.shell_error == 0 and head[1] and head[1] ~= "" then
    return "detached:" .. head[1]
  end

  return nil
end

local function git_root(path)
  local lines = vim.fn.systemlist("git -C " .. vim.fn.shellescape(path) .. " rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error == 0 and lines[1] and lines[1] ~= "" then
    return normalize(lines[1])
  end
  return nil
end

local function add_candidate(candidates, seen, path)
  path = normalize(path)
  if seen[path] then
    return
  end
  if vim.fn.isdirectory(path) ~= 1 then
    return
  end

  seen[path] = true
  table.insert(candidates, path)
end

local function worktree_contexts()
  local candidates = {}
  local seen = {}

  add_candidate(candidates, seen, vim.fn.getcwd())

  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file ~= "" then
    add_candidate(candidates, seen, vim.fn.fnamemodify(current_file, ":p:h"))
  end

  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local cwd = cwd_for_tab(tabpage)
    if cwd then
      add_candidate(candidates, seen, cwd)
    end
  end

  return candidates
end

local function tab_label(tabpage)
  local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
  local cwd = cwd_for_tab(tabpage) or vim.fn.getcwd()
  local win = vim.api.nvim_tabpage_get_win(tabpage)
  local buf = vim.api.nvim_win_get_buf(win)
  local file = vim.api.nvim_buf_get_name(buf)
  local file_label = file ~= "" and vim.fn.fnamemodify(file, ":t") or "[No Name]"
  local cwd_label = vim.fn.fnamemodify(cwd, ":t")
  local branch = git_branch(cwd)
  local current = tabpage == vim.api.nvim_get_current_tabpage() and "*" or " "

  return {
    tabpage = tabpage,
    tabnr = tabnr,
    cwd = cwd,
    branch = branch,
    display = string.format("%s %d  %-28s  %-24s  %s", current, tabnr, branch or cwd_label, cwd_label, file_label),
    ordinal = table.concat({ branch or "", cwd_label, cwd, file_label }, " "),
  }
end

local function parse_worktrees(lines)
  local worktrees = {}
  local current = nil

  for _, line in ipairs(lines) do
    if line == "" then
      if current then
        table.insert(worktrees, current)
        current = nil
      end
    elseif line:sub(1, 9) == "worktree " then
      if current then
        table.insert(worktrees, current)
      end
      current = { path = normalize(line:sub(10)) }
    elseif current and line:sub(1, 7) == "branch " then
      current.branch = short_branch(line:sub(8))
    elseif current and line == "detached" then
      current.detached = true
    elseif current and line:sub(1, 5) == "HEAD " then
      current.head = line:sub(6, 12)
    end
  end

  if current then
    table.insert(worktrees, current)
  end

  for _, worktree in ipairs(worktrees) do
    worktree.name = worktree.branch
      or (worktree.detached and worktree.head and ("detached:" .. worktree.head))
      or vim.fn.fnamemodify(worktree.path, ":t")
  end

  return worktrees
end

local function list_worktrees(path)
  local root = git_root(path)
  if not root then
    return {}
  end

  local lines = vim.fn.systemlist("git -C " .. vim.fn.shellescape(root) .. " worktree list --porcelain 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local repo = vim.fn.fnamemodify(root, ":t")
  local worktrees = parse_worktrees(lines)
  for _, worktree in ipairs(worktrees) do
    worktree.repo = repo
  end

  return worktrees
end

local function get_worktrees()
  local worktrees = {}
  local seen = {}

  for _, candidate in ipairs(worktree_contexts()) do
    for _, worktree in ipairs(list_worktrees(candidate)) do
      if not seen[worktree.path] then
        seen[worktree.path] = true
        table.insert(worktrees, worktree)
      end
    end
  end

  table.sort(worktrees, function(a, b)
    return (a.repo .. a.name .. a.path) < (b.repo .. b.name .. b.path)
  end)

  if vim.tbl_isempty(worktrees) then
    vim.notify("Not inside a git repo; open a repo tab or file first", vim.log.levels.WARN)
  end

  return worktrees
end

function M.open_path(path, opts)
  path = normalize(path)
  opts = opts or {}

  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    if cwd_for_tab(tabpage) == path then
      vim.api.nvim_set_current_tabpage(tabpage)
      return
    end
  end

  vim.cmd("tabnew")
  vim.cmd("tcd " .. vim.fn.fnameescape(path))
  vim.t.worktree_root = path

  if opts.find_files ~= false then
    vim.schedule(function()
      require("telescope.builtin").find_files({ cwd = path })
    end)
  end
end

function M.new_tab_here()
  local cwd = normalize(vim.fn.getcwd())
  vim.cmd("tabnew")
  vim.cmd("tcd " .. vim.fn.fnameescape(cwd))
  vim.t.worktree_root = cwd
end

function M.pick_tabs()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local tabs = vim.tbl_map(tab_label, vim.api.nvim_list_tabpages())

  pickers.new({}, {
    prompt_title = "Open tabs",
    finder = finders.new_table({
      results = tabs,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.ordinal,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.api.nvim_set_current_tabpage(selection.value.tabpage)
        end
      end)
      return true
    end,
  }):find()
end

function M.pick_worktrees()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local worktrees = get_worktrees()
  if vim.tbl_isempty(worktrees) then
    return
  end

  pickers.new({}, {
    prompt_title = "Git worktrees",
    finder = finders.new_table({
      results = worktrees,
      entry_maker = function(entry)
        local path_label = vim.fn.fnamemodify(entry.path, ":~")
        return {
          value = entry,
          display = string.format("%-24s  %-32s  %s", entry.repo or "", entry.name, path_label),
          ordinal = table.concat({
            entry.repo or "",
            entry.name,
            vim.fn.fnamemodify(entry.path, ":t"),
            entry.path,
          }, " "),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          M.open_path(selection.value.path)
        end
      end)
      return true
    end,
  }):find()
end

return M
