#!/bin/sh
function build() {
  local context="${1:-.}"
  shift
  local repository="${1:-$CI_APPLICATION_REPOSITORY}"

  registry_login

  echo "Building Dockerfile"
  docker build \
    --build-arg HTTP_PROXY="$HTTP_PROXY" \
    --build-arg http_proxy="$http_proxy" \
    --build-arg HTTPS_PROXY="$HTTPS_PROXY" \
    --build-arg https_proxy="$https_proxy" \
    --build-arg FTP_PROXY="$FTP_PROXY" \
    --build-arg ftp_proxy="$ftp_proxy" \
    --build-arg NO_PROXY="$NO_PROXY" \
    --build-arg no_proxy="$no_proxy" \
    --tag "$repository:$DOCKER_TAG" \
    --tag "$repository:latest" \
    $context

  echo "Pushing to Container Registry..."
  docker push "$repository:$DOCKER_TAG"
  docker push "$repository:latest"
  echo ""
}
