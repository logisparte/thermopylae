# syntax=docker/dockerfile:1
FROM ubuntu:22.04 AS base

LABEL org.opencontainers.image.title="thermopylae-dev"
LABEL org.opencontainers.image.description="Development image for Thermoypylae"
LABEL org.opencontainers.image.authors="https://logisparte.com"
LABEL org.opencontainers.image.source="https://github.com/logisparte/thermopylae"

ARG DOCKERFILE_USER="docker"

RUN <<EOF
  ln -snf "/usr/share/zoneinfo/UTC" /etc/localtime
  sh -c "echo UTC > /etc/timezone"
  DEBIAN_FRONTEND=noninteractive \
    apt-get update \
      && apt-get install --yes --quiet --no-install-recommends \
        apt-transport-https \
        bash \
        ca-certificates \
        curl \
        git \
        gnupg2 \
        software-properties-common \
        sudo \
        ssh-client \
        tzdata \
        vim \
        wget \
        zsh
  useradd --groups sudo --no-create-home $DOCKERFILE_USER
  passwd --delete $DOCKERFILE_USER
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF

USER $DOCKERFILE_USER

SHELL ["/bin/sh", "-e", "-c"]

CMD ["/bin/sh"]

FROM base AS development

RUN <<EOF
  sudo git config --system init.defaultbranch master
  curl --silent --fail --show-error --location https://deb.nodesource.com/setup_lts.x \
    | sudo -E bash -
  DEBIAN_FRONTEND=noninteractive \
    sudo apt-get update \
      && sudo apt-get install --yes --quiet --no-install-recommends \
        nodejs \
        shfmt \
        shellcheck
  sudo npm config set update-notifier=false fund=false
  sudo npm install --location=global --omit=dev --omit=optional \
    @commitlint/cli \
    markdownlint-cli \
    prettier
  sudo npm cache clean --force
  sudo apt-get clean
  sudo rm -rf /var/lib/apt/lists/*
EOF
