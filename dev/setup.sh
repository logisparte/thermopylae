#!/bin/sh -e

. "$(dirname "$0")/env.sh"
. "$HELPER_DIRECTORY/clear_directory.sh"
. "$HELPER_DIRECTORY/log.sh"

setup() {
  COMPONENT="$1"

  case "$COMPONENT" in
    "" | all)
      log info "Setting up project"
      _setup_hooks
      _setup_docker
      log success "Successfully set up project"
      ;;

    hooks)
      _setup_hooks
      log success "Successfully set up git hooks"
      ;;

    docker)
      _setup_docker
      log success "Successfully set up virtualized development environment"
      ;;

    *)
      fail "Unknown component: $COMPONENT. Use 'all' (default), 'hooks' or 'docker'"
      ;;
  esac
}

_setup_hooks() {
  log info "Setting up git hooks"
  git config --local core.hooksPath "$DEV_DIRECTORY/hooks"
}

_setup_docker() {
  log info "Setting up dockerized development environment"
  _make_docker_host_files
  _build_docker_image
}

_make_docker_host_files() {
  clear_directory "$DOCKER_HOST_DIRECTORY"

  DOCKER_PASSWD_FILE="$DOCKER_HOST_DIRECTORY/passwd"
  DOCKER_GROUP_FILE="$DOCKER_HOST_DIRECTORY/group"
  HOST_USERNAME="$(id -un)"
  HOST_UID="$(id -u)"
  HOST_GID="$(id -g)"

  {
    echo "HOST_USERNAME=$HOST_USERNAME"
    echo "HOST_UID=$HOST_UID"
    echo "HOST_GID=$HOST_GID"
    echo "DOCKER_GROUP_FILE=$DOCKER_GROUP_FILE"
    echo "DOCKER_PASSWD_FILE=$DOCKER_PASSWD_FILE"
    echo "COMPOSE_PROJECT_NAME=$(basename "$PWD")"
  } > "$DOCKER_COMPOSE_ENV_FILE"

  {
    if [ "${HOST_UID}" != "0" ]; then
      echo "root:x:0:0:root:/root:/bin/sh"
    fi

    echo "${HOST_USERNAME}:x:${HOST_UID}:${HOST_GID}:${HOST_USERNAME}:${HOME}:${SHELL:-/bin/sh}"
  } > "$DOCKER_PASSWD_FILE"

  echo "${HOST_USERNAME}:x:${HOST_GID}:" > "$DOCKER_GROUP_FILE"
}

_build_docker_image() {
  docker compose \
    --file "$DOCKER_COMPOSE_FILE" \
    --env-file "$DOCKER_COMPOSE_ENV_FILE" \
    build
}

setup "$@"
