#!/bin/sh

. "$HELPER_DIRECTORY/log.sh"

fail() {
  MESSAGE="$1"

  log error "$MESSAGE"
  exit 1
}
