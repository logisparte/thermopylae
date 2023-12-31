#!/bin/sh
# shellcheck disable=SC2317

. "$HELPER_DIRECTORY/colorize.sh"

log() {
  LEVEL="$1"

  message() {
    MESSAGE="$1"
    COLOR="$2"

    SCRIPT_NAME="$(basename "$0" | cut -d "." -f 1)"
    if [ -n "$COLOR" ]; then
      printf "%s\n" "$(colorize "[$SCRIPT_NAME] $MESSAGE" "$COLOR")"

    else
      printf "%s\n" "[$SCRIPT_NAME] $MESSAGE"
    fi
  }

  success() {
    MESSAGE="$1"

    message "$MESSAGE" green
  }

  info() {
    MESSAGE="$1"

    message "$MESSAGE" cyan
  }

  warning() {
    MESSAGE="$1"

    message "$MESSAGE" yellow
  }

  error() {
    MESSAGE="$1"

    message "$MESSAGE" red >&2
  }

  case "$LEVEL" in
    message | success | info | warning | error)
      shift
      "$LEVEL" "$@"
      ;;

    *)
      echo "$@"
      ;;
  esac
}
