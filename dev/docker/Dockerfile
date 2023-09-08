# syntax=docker/dockerfile:1
FROM ubuntu:22.04 AS base

LABEL org.opencontainers.image.title="thermopylae-dev"
LABEL org.opencontainers.image.description="Development image for Thermopylae"
LABEL org.opencontainers.image.authors="https://logisparte.com"
LABEL org.opencontainers.image.source="https://github.com/logisparte/thermopylae"

ARG DOCKERFILE_USER="docker"

ENV IS_IN_DOCKER=true

RUN <<EOF
  DEBIAN_FRONTEND=noninteractive \
    apt-get update \
      && apt-get install --yes --quiet --no-install-recommends \
        sudo
  useradd --groups sudo --no-create-home $DOCKERFILE_USER
  passwd --delete $DOCKERFILE_USER
  sudo apt-get clean
  sudo rm -rf /var/lib/apt/lists/*
EOF

USER $USER

SHELL ["/bin/sh", "-e", "-c"]

CMD ["/bin/sh"]

FROM base AS system

RUN <<EOF
  sudo ln -snf "/usr/share/zoneinfo/UTC" /etc/localtime
  sudo sh -c "echo UTC > /etc/timezone"
  DEBIAN_FRONTEND=noninteractive \
    sudo apt-get update \
      && sudo apt-get install --yes --quiet --no-install-recommends \
        apt-transport-https \
        bash \
        ca-certificates \
        curl \
        git \
        gnupg2 \
        software-properties-common \
        ssh-client \
        tzdata \
        vim \
        wget \
        zsh
  sudo apt-get clean
  sudo rm -rf /var/lib/apt/lists/*
EOF

FROM system AS project

RUN <<EOF
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
    | sudo tee /etc/apt/sources.list.d/nodesource.list
  DEBIAN_FRONTEND=noninteractive \
    sudo apt-get update \
      && sudo apt-get install --yes --quiet --no-install-recommends \
        nodejs \
        shellcheck \
        shfmt
  sudo npm config set --location=global update-notifier=false fund=false
  sudo npm install --location=global --omit=dev --omit=optional \
    @commitlint/cli \
    markdownlint-cli \
    prettier
  sudo npm cache clean --force
  sudo apt-get clean
  sudo rm -rf /var/lib/apt/lists/*
EOF
