#!/bin/bash

TMP_IMAGE="$1"
TAG="$2"

skopeo inspect oci:"$TMP_IMAGE":"$TAG" | jq -r '.Layers | .[]' | (
  read CHAIN; echo "$CHAIN"; while read LAYER; do
    CHAIN="sha256:$(printf "%s %s" "$CHAIN" "$LAYER" | sha256sum | cut -d' ' -f1)"
    echo "$CHAIN"
  done
) | sed '1!G;h;$!d'
