#!/bin/sh

clear_directory() {
  DIRECTORY_PATH="$1"

  rm -rf "$DIRECTORY_PATH"
  mkdir -p "$DIRECTORY_PATH"
}
