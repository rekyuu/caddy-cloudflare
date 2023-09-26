#! /bin/bash

CADDY_MAJOR_VERSION="2"
CADDY_MINOR_VERSION="7"
CADDY_PATCH_VERSION="4"

IMAGE_NAME=""
CADDY_VERSION="$CADDY_MAJOR_VERSION.$CADDY_MINOR_VERSION.$CADDY_PATCH_VERSION"
CADDY_MINOR="$CADDY_MAJOR_VERSION.$CADDY_MINOR_VERSION"

BUILDKIT_NAME=$(docker buildx create --use)

docker buildx build \
    --build-arg="CADDY_VERSION=$CADDY_VERSION" \
    --platform linux/amd64,linux/arm/v7 \
    -t "$IMAGE_NAME:$CADDY_VERSION-alpine" \
    -t "$IMAGE_NAME:$CADDY_MINOR-alpine" \
    -t "$IMAGE_NAME:$CADDY_MAJOR_VERSION-alpine" \
    -t "$IMAGE_NAME:alpine" \
    -t "$IMAGE_NAME:$CADDY_VERSION" \
    -t "$IMAGE_NAME:$CADDY_MINOR" \
    -t "$IMAGE_NAME:$CADDY_MAJOR_VERSION" \
    -t "$IMAGE_NAME:latest" \
    --push \
    .

docker buildx rm "$BUILDKIT_NAME"