#!/bin/sh
[[ "$TRACE" ]] && set -eu

export VERSION="$( (git describe --tags  2>/dev/null || echo 0.0.0) | sed 's|.\([0-9]*\)-\([0-9]*\)|.\1+\2|')"
export DOCKER_TAG="$(echo $VERSION | sed 's|+|_|')"

function setup_docker() {
  if ! docker info &>/dev/null; then
    if [ -z "$DOCKER_HOST" -a "$KUBERNETES_PORT" ]; then
      export DOCKER_HOST='tcp://localhost:2375'
    fi
  fi
}

function registry_login() {
  if [[ -n "$CI_REGISTRY_USER" ]]; then
    echo "Logging to Container Registry with CI credentials..."
    docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"
    echo ""
  fi
}
