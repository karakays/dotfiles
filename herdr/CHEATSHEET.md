# Herdr Cheatsheet

Prefix: `Ctrl-b`

Press the prefix, release it, then press the action key.

## Concepts

| Herdr | tmux equivalent | Purpose |
| --- | --- | --- |
| Session | Server/session namespace | Isolated persistent runtime |
| Space/workspace | Session/project | Repository, task, or investigation |
| Tab | Window | Layout within a workspace |
| Pane | Pane | Terminal running a shell, process, or agent |
| Client | Client | UI attached from Alacritty |

Use one default session with a workspace per repository or active worktree.

## Essential

| Keys | Action |
| --- | --- |
| `Prefix ?` | Show active keybindings |
| `Prefix Shift-d` | Detach and leave everything running |
| `Prefix f` | Open Herdr Navigator |
| `Prefix g` | Open Herdr's native session navigator |
| `Prefix w` | Open workspace navigation |
| `Prefix b` | Toggle the sidebar |
| `Prefix r` | Reload Herdr configuration |
| `Prefix Shift-s` | Open Herdr settings |
| `Prefix Shift-o` | Open the current notification target |

Run `herdr` again to reattach. Run `herdr server stop` to stop the default
session and its processes.

## Workspaces

| Keys | Action |
| --- | --- |
| `Prefix Shift-n` | New workspace |
| `Prefix Shift-w` | Rename workspace |
| `Prefix Shift-q` | Close workspace |
| `Prefix Shift-g` | New Git worktree |
| `j/k` | Select next/previous workspace in workspace navigation |
| `Enter` | Focus the selected workspace |
| `Esc` | Leave workspace navigation |

## Herdr Navigator

| Keys | Action |
| --- | --- |
| `Prefix f` | Open Navigator in normal mode |
| `/` | Clear the query and enter search mode |
| `Esc` | Leave search mode and keep the filtered results |
| `j/k` | Select next/previous result in normal mode |
| `Enter` | Open the selected result |
| `Tab` | Cycle source filters |
| `Ctrl-o` | Toggle preview |

Navigator searches Herdr workspaces, agents, sessions, projects, zoxide
history, configured roots, remotes, and integrations. `Prefix g` remains
Herdr's native workspace/tab/pane/agent navigator.

Install the pinned plugin release with:

```bash
herdr plugin install thanhdat77/herdr-navigator --ref v0.3.6 --yes
```

## Tabs

| Keys | Action |
| --- | --- |
| `Prefix c` | New tab |
| `Prefix n` | Next tab |
| `Prefix p` | Previous tab |
| `Prefix 1..9` | Switch to tab by number |
| `Prefix Shift-t` | Rename tab |
| `Prefix Shift-x` | Close tab |

## Panes

| Keys | Action |
| --- | --- |
| `Prefix h/j/k/l` | Focus pane left/down/up/right |
| `Prefix Shift-h/j/k/l` | Swap pane left/down/up/right |
| `Prefix v` | Split side by side |
| `Prefix s` | Split above/below |
| `Prefix Tab` | Cycle to next pane |
| `Prefix -` | Return to the previously focused pane |
| `Prefix Shift-Tab` | Cycle to previous pane |
| `Prefix x` | Close pane |
| `Prefix z` | Zoom pane |
| `Prefix Shift-r` | Enter resize mode |

## Scrollback and Copy Mode

| Keys | Action |
| --- | --- |
| `Prefix Space` | Enter copy mode |
| `Prefix e` | Open scrollback in `$EDITOR` |
| `h/j/k/l` | Move in copy mode |
| `w/b/e` | Move by word |
| `/` or `?` | Search forward or backward |
| `n` or `N` | Repeat search |
| `v` or `Space` | Start selection |
| `y` or `Enter` | Copy selection |
| `q` or `Esc` | Exit copy mode |

## Useful Commands

```bash
herdr
herdr status
herdr session list
herdr workspace list
herdr tab list
herdr pane list
herdr server reload-config
herdr server stop
```

## Known Differences from tmux

- `Prefix o` does not close every other pane.
- `Prefix Ctrl-b` sends a literal `Ctrl-b`; use `Prefix Tab` to cycle panes.
- Rectangle selection with `Ctrl-v` is not available in Herdr copy mode.
