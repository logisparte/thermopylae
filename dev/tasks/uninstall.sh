#!/bin/sh

. "$HELPER_DIRECTORY/log.sh"

uninstall_help() {
  echo "Uninstall git hooks"
}

uninstall() {
  log info "[uninstall] Uninstalling git hooks"
  if git config --local --get core.hooksPath > /dev/null; then
    git config --local --unset core.hooksPath
  fi

  log success "[uninstall] Successfully uninstalled git hooks"
}
