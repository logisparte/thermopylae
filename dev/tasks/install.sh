#!/bin/sh

. "$HELPER_DIRECTORY/log.sh"

install_help() {
  echo "Install git hooks"
}

install() {
  log info "[install] Installing git hooks"
  git config --local core.hooksPath "$HOOK_DIRECTORY"
  log success "[install] Successfully installed git hooks"
}
