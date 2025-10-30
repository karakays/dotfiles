# Load SSH keys from macOS Keychain
# Keys must be previously added with: ssh-add --apple-use-keychain ~/.ssh/keyname
ssh-add --apple-load-keychain 2>/dev/null
