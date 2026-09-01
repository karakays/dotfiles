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
| `Prefix f` | Open Herdr Bar |
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

## Herdr Bar

| Keys | Action |
| --- | --- |
| `Prefix f` | Open Bar and start typing to search |
| `Ctrl-j` / `Ctrl-k` | Select next/previous result |
| `Enter` | Jump to the selected result |
| `Tab` / `Shift-Tab` | Cycle source filters |
| `Ctrl-o` | Toggle preview |
| `Ctrl-r` | Rename the selected tab |
| `Esc` | Close Bar without changing focus |

Bar searches active Herdr agents, plain tabs, and workspaces. It does not search
zoxide history or unopened directories. `Prefix g` remains Herdr's native
workspace/tab/pane/agent navigator.

Install the pinned plugin release with:

```bash
herdr plugin install jeffarese/herdr-bar --ref v0.2.1 --yes
```

## Hunk Reviews

| Keys | Action |
| --- | --- |
| `Prefix h` | Review uncommitted working-tree changes |
| `Prefix Shift-b` | Review committed branch changes against the resolved base |
| `Prefix Shift-h` | Send unsent review comments to the associated agent |

The Hunk review pane is reused when switching between working-tree and branch
reviews. Branch review uses `<resolved-base>...HEAD`, so it includes committed
branch changes but not current uncommitted changes.

The base is resolved from a suitable upstream, then `origin/HEAD`, then the
first local branch named `main`, `master`, or `trunk`.

Install the plugin with:

```bash
herdr plugin install jhochenbaum/herdr-hunk-diff --yes
```

CLI fallbacks:

```bash
herdr plugin action invoke review --plugin jhochenbaum.hunkdiff
herdr plugin action invoke review:branch --plugin jhochenbaum.hunkdiff
herdr plugin action invoke review:staged --plugin jhochenbaum.hunkdiff
herdr plugin action invoke review:commit --plugin jhochenbaum.hunkdiff
herdr plugin action invoke review:stash --plugin jhochenbaum.hunkdiff
herdr plugin action invoke send-review --plugin jhochenbaum.hunkdiff
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
