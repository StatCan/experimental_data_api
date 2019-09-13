#!/bin/sh
function deploy() {
  if [ -n "$OCTOPUS_CHANNEL" ]; then
    export CHANNEL="--channel $OCTOPUS_CHANNEL"
  else
    export CHANNEL=""
  fi

  octo create-release \
    --progress \
    --waitfordeployment \
    --project "$OCTOPUS_PROJECT" \
    --space "$OCTOPUS_SPACE" \
    --version "$VERSION" \
    --deployto "$OCTOPUS_LIFECYCLE_ROOT" \
    --server "$OCTOPUS_API_URL" \
    --apiKey $OCTOPUS_API_KEY \
    --variable="IMAGE_TAG=$DOCKER_TAG" \
    $CHANNEL
}
