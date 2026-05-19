#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-main}"
TAG="${TAG//\//-}"
IMAGE="ghcr.io/aerostacks/tusd-custom"

DOCKER_BUILDKIT=1 docker buildx build \
  --builder aerostacks \
  --platform linux/amd64 \
  -t "${IMAGE}:${TAG}" \
  --push .
