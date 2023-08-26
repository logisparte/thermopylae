#!/bin/sh

. "$HELPER_DIRECTORY/colorize.sh"
. "$HELPER_DIRECTORY/confirm.sh"
. "$HELPER_DIRECTORY/fail.sh"
. "$HELPER_DIRECTORY/log.sh"
. "$TASK_DIRECTORY/version.sh"

tag_help() {
  echo "Tag latest commit following semantic versioning conventions"
}

tag() {
  CURRENT_VERSION="$(version)"
  log message "Current version is: $(colorize "$CURRENT_VERSION" green)"

  CURRENT_MAJOR_VERSION="$(echo "$CURRENT_VERSION" | cut -d "." -f 1)"
  CURRENT_MINOR_VERSION="$(echo "$CURRENT_VERSION" | cut -d "." -f 2)"
  CURRENT_PATCH_VERSION="$(echo "$CURRENT_VERSION" | cut -d "." -f 3)"

  log message "
Select new version type:
  $(colorize "1. Major" cyan)
  $(colorize "2. Minor" cyan)
  $(colorize "3. Patch" cyan)
"
  read -r SELECTED_VERSION_TYPE
  case "$SELECTED_VERSION_TYPE" in
    1)
      NEW_MAJOR_VERSION="$((CURRENT_MAJOR_VERSION + 1))"
      NEW_MINOR_VERSION="0"
      NEW_PATCH_VERSION="0"
      ;;

    2)
      NEW_MAJOR_VERSION="$CURRENT_MAJOR_VERSION"
      NEW_MINOR_VERSION="$((CURRENT_MINOR_VERSION + 1))"
      NEW_PATCH_VERSION="0"
      ;;

    3)
      NEW_MAJOR_VERSION="$CURRENT_MAJOR_VERSION"
      NEW_MINOR_VERSION="$CURRENT_MINOR_VERSION"
      NEW_PATCH_VERSION="$((CURRENT_PATCH_VERSION + 1))"
      ;;

    *)
      fail "Bad new version type selection: enter 1, 2 or 3"
      ;;
  esac

  NEW_VERSION="v$NEW_MAJOR_VERSION.$NEW_MINOR_VERSION.$NEW_PATCH_VERSION"
  log message "New version will be: $(colorize "$NEW_VERSION" green)"

  log message "Enter tag message:"
  read -r TAG_MESSAGE

  QUESTION="
About to tag $(colorize "$REPOSITORY" green) as $(colorize "$NEW_VERSION" green) with message:
  $TAG_MESSAGE

$(colorize "Proceed?" yellow)"

  if confirm "$QUESTION"; then
    git tag --annotate "$NEW_VERSION" --message "$TAG_MESSAGE"
    git push --tags
  fi
}
