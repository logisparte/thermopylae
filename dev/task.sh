#!/bin/sh -e

export DEV_DIRECTORY="$PWD/dev"
export DOCKER_DIRECTORY="$DEV_DIRECTORY/docker"
export HELPER_DIRECTORY="$DEV_DIRECTORY/helpers"
export HOOK_DIRECTORY="$DEV_DIRECTORY/hooks"
export TASK_DIRECTORY="$DEV_DIRECTORY/tasks"

. "$HELPER_DIRECTORY/does_file_exist.sh"
. "$HELPER_DIRECTORY/fail.sh"

task() {
  TASK="${1:-help}"

  if ! does_file_exist "$TASK_DIRECTORY/$TASK.sh"; then
    fail "Task not found: '$TASK'"
  fi

  shift
  . "$DEV_DIRECTORY/environment.sh"
  . "$TASK_DIRECTORY/$TASK.sh"
  "$TASK" "$@"
}

task "$@"
