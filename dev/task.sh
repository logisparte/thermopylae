#!/bin/sh -e

. "$(dirname "$0")/env.sh"
. "$HELPER_DIRECTORY/does_file_exist.sh"
. "$HELPER_DIRECTORY/fail.sh"

task() {
  TASK="${1:-help}"

  if ! does_file_exist "$TASK_DIRECTORY/$TASK.sh"; then
    fail "Task not found: '$TASK'"
  fi

  . "$TASK_DIRECTORY/$TASK.sh"
  shift || true
  "$TASK" "$@"
}

task "$@"
