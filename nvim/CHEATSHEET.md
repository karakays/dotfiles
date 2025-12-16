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

- `<leader>g` - Git status (fugitive)
- `<leader>gg` - **LazyGit** (full TUI)

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
- `s` - Save file
- `q` - Quit
- `<Space>` - Clear search highlight
- `<CR>` - Create blank line below
- `<C-j>` - Scroll down
- `<C-k>` - Scroll up

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
