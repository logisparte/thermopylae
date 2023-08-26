#!/bin/sh

. "$HELPER_DIRECTORY/colorize.sh"
. "$HELPER_DIRECTORY/does_symbol_exist.sh"

help_help() {
  echo "Show this help message"
}

help() {
  _get_help_output | awk -F "|" '{printf "%-32s %s\n", $1, $2}'
}

_get_help_output() {
  echo "|"
  echo "$(colorize "Available tasks:" orange)|"
  echo "|"
  for FILE in "$TASK_DIRECTORY"/*; do
    . "$FILE"
    TASK="$(basename "$FILE" | cut -d "." -f 1)"
    echo "$(colorize "$TASK" orange)|$(_get_task_help "$TASK")"
  done
}

_get_task_help() {
  TASK="$1"

  TASK_HELP_FUNCTION="${TASK}_help"
  if does_symbol_exist "$TASK_HELP_FUNCTION"; then
    "$TASK_HELP_FUNCTION"

  else
    echo "-"
  fi
}
