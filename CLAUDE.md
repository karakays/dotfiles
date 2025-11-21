# Development Guide for Claude

This document provides context and conventions for working on this dotfiles repository.

## Repository Structure

This is a personal dotfiles repository containing configuration files for:
- **zsh**: Shell configuration and custom scripts
- **tmux**: Terminal multiplexer configuration
- **nvim**: Neovim editor configuration
- Other development tools and utilities

## Deployment

Dotfiles are deployed using [GNU Stow](https://www.gnu.org/software/stow/):

```bash
stow .
```

This creates symlinks from the repository directories to the appropriate locations in the home directory. For example:
- `zsh/.zshrc` → `~/.zshrc`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `nvim/` → `~/.config/nvim/`

**Important**: After making changes to dotfiles, they take effect immediately since the home directory files are symlinked to this repository.

## Git Workflow

**This repository pushes directly to the `master` branch.** There are no pull requests or feature branches - all commits go straight to main.

When committing:
- Create clear, descriptive commit messages
- Push changes directly to master after committing
- Use force push when necessary (e.g., after rewriting history to remove secrets)

## File Conventions

### Local/Private Configuration Files

**Convention**: Use the `*.local.*` or `*.local` suffix for any files containing:
- Secrets (API tokens, credentials, passwords)
- Company-specific configuration
- Machine-specific settings
- Any data that should not be committed to version control

**Examples**:
- `env.local.zsh` - Local environment variables with secrets
- `config.local.json` - Private configuration overrides
- `settings.local.yaml` - Machine-specific settings

**Templates**: For local files, create a corresponding `.template` file that can be committed:
- `env.local.zsh.template` - Example showing what should go in `env.local.zsh`
- Template files are allowed in git via gitignore exceptions

**Gitignore Pattern**:
```
*.local.*
!*.local.*.template
*.local
!*.local.template
```

### Migration from Old Patterns

If you encounter files with company-specific suffixes (like `-lvh.zsh`, `-company.sh`, etc.), migrate them to the `*.local.*` pattern and remove them from git history if they contain secrets.

## Security

- **Never commit secrets** - Use `*.local.*` files for any credentials or tokens
- **Clean git history** - If a secret is accidentally committed, use `git filter-branch` to remove it from history and force push
- **GitHub Push Protection** - The repository has secret scanning that will block pushes containing detected secrets

## Documentation

- **tmux/CHEATSHEET.md** - Quick reference for tmux keybindings and commands
- Keep documentation concise and up-to-date with actual configurations
