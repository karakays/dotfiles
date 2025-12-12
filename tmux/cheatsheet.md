# Tmux Keybindings Quick Reference

## Copy Mode (tmux-yank)

**Enter copy-mode:** `Ctrl-b Space`

Once in copy-mode:
- `v` - Start visual selection
- `C-v` - Rectangle/block selection
- `y` - Copy selection to clipboard
- `Y` - Copy selection and paste to command line

**Mouse:** Click-drag-release automatically copies to clipboard

---

## tmux-fingers (Hint-based Copying)

**Trigger:** `Ctrl-b Shift-F` (uppercase F)

- Displays hints (like `aa`, `ab`, etc.) over copyable text
- Type the hint letters to copy that text
- Automatically detects: file paths, URLs, IPs, hashes, numbers

**In fingers mode:**
- `a-z` - Copy match
- `Ctrl + a-z` - Copy and open in browser
- `Shift + a-z` - Copy and paste
- `Tab` - Multi-select mode
- `q` or `Esc` - Exit

---

## tmux-open (Smart File/URL Opener)

**In copy-mode:**
1. `Ctrl-b Space` - Enter copy-mode
2. Navigate to file path or URL
3. `v` - Highlight the path/URL
4. `o` - Open (URLs → browser, files → system default)
5. `Ctrl-o` - Open in $EDITOR (vi)

---

## Other Useful Bindings

**Panes:**
- `Ctrl-b v` - Split vertical
- `Ctrl-b s` - Split horizontal
- `Ctrl-b h/j/k/l` - Navigate panes

**Windows:**
- `Ctrl-b c` - New window
- `Ctrl-b n/p` - Next/previous window
- `Ctrl-b 0/9` - First/last window

**Sessions:**
- `Ctrl-b ,/.` - Previous/next session
- `Ctrl-b f` - **Fuzzy find sessions/projects (sesh)**
  - Type instantly to filter
  - `Enter` - Switch to session
  - `Ctrl-t` - Show only tmux sessions
  - `Ctrl-x` - Show zoxide frequent dirs (auto-creates sessions)
  - `Ctrl-d` - Kill selected session

**Other:**
- `Ctrl-b r` - Reload config
