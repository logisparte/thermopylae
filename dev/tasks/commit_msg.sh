#!/bin/sh

. "$HELPER_DIRECTORY/colorize.sh"

commit_msg_help() {
  echo "$(colorize "[git hook]" purple) Lint commit message"
}

commit_msg() {
  MESSAGE="$1"

  commitlint --edit "$MESSAGE"
}
