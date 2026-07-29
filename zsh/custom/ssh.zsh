# Manually reload SSH keys from macOS Keychain if the agent loses them.
# Keys should be registered once with: ssh-add --apple-use-keychain ~/.ssh/keyname
ssh-load-keychain() {
  ssh-add --apple-load-keychain "$@"
}
