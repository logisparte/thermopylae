#!/bin/sh

. "$HELPER_DIRECTORY/fail.sh"
. "$HELPER_DIRECTORY/git/list_all_files.sh"
. "$HELPER_DIRECTORY/git/list_dirty_files.sh"
. "$HELPER_DIRECTORY/log.sh"

format_help() {
  echo "Format files to ensure visual consistency"
}

format() {
  FILTER="$1"

  case "$FILTER" in
    dirty | "")
      FILTERED_FILES="$(list_dirty_files)"
      ;;

    all)
      FILTERED_FILES="$(list_all_files)"
      ;;

    *)
      fail "[format] Unknown file filter: '$FILTER'. Use 'dirty' (default) or 'all'"
      ;;
  esac

  _format_shell "$FILTERED_FILES"
  _format_markdown_and_yaml "$FILTERED_FILES"
  log success "[format] Successfully formatted files"
}

_format_shell() {
  FILES="$1"

  SHELL_FILES="$(echo "$FILES" | grep -e "\.sh$" || true)"
  if [ -z "$SHELL_FILES" ]; then
    return
  fi

  _info "Formatting shell files"
  log message "$SHELL_FILES" "gray"
  echo "$SHELL_FILES" | xargs shfmt -p -w -bn -ci -sr -i 2
}

_format_markdown_and_yaml() {
  FILES="$1"

  MARKDOWN_YAML_FILES="$(echo "$FILES" | grep -e "\.md$" -e "\.yml$" -e "\.yaml$" || true)"
  if [ -z "$MARKDOWN_YAML_FILES" ]; then
    return
  fi

  _info "Formatting markdown and yaml files"
  echo "$MARKDOWN_YAML_FILES" | xargs prettier --write
}

_info() {
  MESSAGE="$1"

  log info "[format] $MESSAGE"
}
