## TODO
- auto-mount keybase fs
- auto-mount rclone
- git config --worktree

## Improvements
- First time cloning, any submodules need to be initialized like vim submodules
- Provision keys from keybase
- keybase mounts can only be accessed with `keybase fs` commands which prevents `ssh` to read host configuration from .ssh/config.d/\*
- import ideavimrc keybindings

## Bug
- postgresql prompt now working
- tmux process initiated twice on startup
- fix apt repos with wrong signatures

## Promising
- Check how display manager can be tweaked with
    * ~/.xinitrc and ~/.xsession
- Install vim-surround by tpope
- nc netcat tool

