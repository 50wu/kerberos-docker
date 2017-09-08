#!/usr/bin/env bash
#
# pre-build.sh
#
# Pre-Build docker images for kerberos cluster.

cd "$(dirname "$0")"
cd ..

source .env

image_name="minimal-${OS_CONTAINER}"
image_id=$(docker images "${image_name}" | sed 1d)

if [[ -n "${image_id}" ]]; then
  echo "Docker image '${image_name}' already exists!"
  exit 0
fi

# Build template minimal operating system for each container
echo "=== pre-build docker image 'minimal-${OS_CONTAINER}' ==="
docker build -t  "${image_name}" "./${PREFIX_KRB5}-${OS_CONTAINER}"
