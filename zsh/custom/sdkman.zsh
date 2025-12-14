# Initialize SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
export SDKMAN_AUTO_ENV=true
export SDKMAN_AUTO_ANSWER=true

# Ensure JAVA_HOME is set (jdtls requires this)
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
