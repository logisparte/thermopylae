#!/bin/sh

. "$HELPER_DIRECTORY/colorize.sh"
. "$HELPER_DIRECTORY/log.sh"

confirm() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -y | --yes)
        ANSWER="y"
        ;;

      -n | --no)
        ANSWER="n"
        ;;

      -*)
        fail "Unknown flag: $1"
        ;;

      *)
        break
        ;;
    esac

    shift
  done

  QUESTION="${1-"Are you sure?"}"
  if [ -z "$ANSWER" ]; then
    QUESTION_COLOR="bold_white"
    OPTIONS_COLOR="244"
    log message \
      "$(colorize "$QUESTION" "$QUESTION_COLOR") $(colorize "[y/n]" "$OPTIONS_COLOR") "
    ANSWER="$(_read_answer)"
  fi

  case "$ANSWER" in
    [yY])
      unset ANSWER
      true
      ;;

    *)
      unset ANSWER
      false
      ;;
  esac
}

_read_answer() {
  read -r ANSWER
  printf "%s" "$ANSWER"
}
