#!/bin/sh

. "$HELPER_DIRECTORY/colorize.sh"
. "$HELPER_DIRECTORY/fail.sh"
. "$HELPER_DIRECTORY/log.sh"

pre_commit_help() {
  echo "$(colorize "[git hook]" purple) Format and lint code about to be commited"
}

pre_commit() {
  _stash_unstaged_files
  _format
  _lint
  if [ $? ]; then
    _unstash_unstaged_files

  else
    fail "[pre_commit] linting failed, unstaged changes are still stashed"
  fi
}

_stash_unstaged_files() {
  _info "Stashing unstaged changes"
  git stash push \
    --include-untracked \
    --keep-index \
    --message "pre_commit: unstaged changes" \
    --quiet
}

_format() {
  _emphasis_info ">>"
  ./dev/task.sh format
  git add .
  _emphasis_info "<<"
}

_lint() {
  _emphasis_info ">>"
  ./dev/task.sh lint
  _emphasis_info "<<"
}

_unstash_unstaged_files() {
  _info "Unstashing unstaged changes"
  git stash pop --quiet
}

_info() {
  MESSAGE="$1"

  log info "[pre_commit] $MESSAGE"
}

_emphasis_info() {
  MESSAGE="$1"

  log message "$(colorize "[pre_commit]" cyan) $(colorize "$MESSAGE" bold_white)"
}
