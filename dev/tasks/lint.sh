#!/bin/sh

. "$HELPER_DIRECTORY/fail.sh"
. "$HELPER_DIRECTORY/git/list_all_files.sh"
. "$HELPER_DIRECTORY/git/list_dirty_files.sh"
. "$HELPER_DIRECTORY/log.sh"

lint_help() {
  echo "Lint files to ensure best practices and prevent errors"
}

lint() {
  FILTER="$1"

  case "$FILTER" in
    dirty | "")
      FILTERED_FILES="$(list_dirty_files)"
      ;;

    all)
      FILTERED_FILES="$(list_all_files)"
      ;;

    *)
      fail "[lint] Unknown file filter: '$FILTER'. Use 'dirty' (default) or 'all'"
      ;;
  esac

  _lint_shell "$FILTERED_FILES"
  _lint_markdown "$FILTERED_FILES"
  log success "[lint] Successfully linted files"
}

_lint_shell() {
  FILES="$1"

  SHELL_FILES="$(echo "$FILES" | grep -e "\.sh$" || true)"
  if [ -z "$SHELL_FILES" ]; then
    return
  fi

  _info "linting shell files"
  log message "$SHELL_FILES" "gray"
  echo "$SHELL_FILES" | xargs shellcheck
}

_lint_markdown() {
  FILES="$1"

  MARKDOWN_FILES="$(echo "$FILES" | grep -e "\.md$" || true)"
  if [ -z "$MARKDOWN_FILES" ]; then
    return
  fi

  _info "linting markdown files"
  log message "$MARKDOWN_FILES" "gray"
  echo "$MARKDOWN_FILES" | xargs markdownlint
}

_info() {
  MESSAGE="$1"

  log info "[lint] $MESSAGE"
}
