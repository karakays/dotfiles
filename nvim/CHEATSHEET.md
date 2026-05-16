# Neovim Keybindings Quick Reference

**Leader key:** `<Space>`

---

## File Navigation (Telescope)

- `<leader>ff` - **Find files** (fuzzy file finder)
- `<leader>fg` - **Live grep** (search text across project)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<C-j>/<C-k>` - Navigate results (vim style)

---

## File Explorer (NvimTree)

- `<leader>o` - **Toggle & reveal current file in tree**

**Inside NvimTree:**
- `a` - Create file/directory
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `<CR>` - Open file

---

## Git

- `<leader>gg` - **LazyGit** (full TUI)
- `<leader>gh` - **Open line in GitHub** (visual: range)

---

## LSP & Code

- `gd` - Go to definition
- `gr` - **Go to references** (all usages)
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>lf` - Format document
- `<leader>ds` - **Document symbols** (outline picker)
- `<leader>ci` - **Incoming calls** (who calls this function?)
- `<leader>co` - **Outgoing calls** (what does this function call?)
- `<C-Space>` - Trigger completion

---

## Tabs

- `tn` - New tab
- `tq` - Close tab
- `tj` - Previous tab
- `tk` - Next tab
- `t0` - First tab
- `t9` - Last tab

---

## Navigation & Editing

- `jk` - Exit insert mode (instead of Esc)
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<Esc>` - Clear search highlight (normal mode)
- `<leader><CR>` - Create blank line below
- `<C-j>` - Scroll down
- `<C-k>` - Scroll up

---

## Treesitter Text Objects

Use with any operator (`d`/`c`/`y`/`v`). Includes lookahead — if cursor isn't inside the target, jumps to the next one.

**Functions:**
- `vaf` / `vif` - Select a/inside **function**
- `daf` / `dif` - Delete a/inside function
- `caf` / `cif` - Change a/inside function (great for rewriting bodies)
- `yaf` / `yif` - Yank a/inside function

**Classes:**
- `vac` / `vic` - Select a/inside **class**
- `dac` / `dic` - Delete a/inside class

**Parameters/Arguments:**
- `vaa` / `via` - Select a/inside **parameter** (`aa` = with comma)
- `daa` / `dia` - Delete a/inside parameter

**Conditionals & loops:**
- `vai` / `vii` - Select a/inside **if-statement**
- `val` / `vil` - Select a/inside **loop**

**Movement (with jump list — `<C-o>` returns):**
- `]m` / `[m` - Next / previous **function start**
- `]M` / `[M` - Next / previous function end
- `]]` / `[[` - Next / previous **class start**
- `][` / `[]` - Next / previous class end

---

## Folding

- `za` - Toggle fold
- `zO` - Open all folds
- `zM` - Close all folds
- `zr` - Reduce fold level
- `zm` - Increase fold level

---

## Markdown

- `<leader>mr` - Toggle markdown rendering

---

## Config

- `<leader>ve` - Edit config
- `<leader>vs` - Source/reload config
