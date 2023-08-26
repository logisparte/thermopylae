#!/bin/sh

version_help() {
  echo "Echo current version of project"
}

version() {
  git for-each-ref --sort=taggerdate --format "%(refname)" refs/tags \
    | tail -n 1 \
    | cut -d "/" -f 3
}
