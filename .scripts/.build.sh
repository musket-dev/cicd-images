#!/bin/sh
CURR_DIR=$(dirname $0);
IMAGE_URL=$1
IMAGE_TAG=$2;
BUILD_ARGS=$3;
if [ "${IMAGE_URL}" = "" ]; then
  printf "\n\e[31m\e[1m[!] Specify the namspace to build as the first argument.\e[0m\n";
  exit 1;
fi;

if [ "${IMAGE_TAG}" = "" ]; then
  printf "\n\e[31m\e[1m[!] Specify the image (directory name) to build as the second argument.\e[0m\n";
  exit 1;
fi;

REPOSITORY_URL=${IMAGE_URL}:${IMAGE_TAG};
NEXT_TAG="${REPOSITORY_URL}-next";
if [ "${BUILD_ARGS}" != "" ]; then
  ADDITIONAL_BUILD_ARGS="$(echo "${BUILD_ARGS}" | sed -e $'s|,|\\\n|g' | xargs -I @ echo '--build-arg @')";
else
  ADDITIONAL_BUILD_ARGS="";
fi;

docker build \
  ${ADDITIONAL_BUILD_ARGS} \
  --no-cache \
  --file ${CURR_DIR}/../${IMAGE_TAG}/Dockerfile \
  --tag "${NEXT_TAG}" \
  ${CURR_DIR}/../${IMAGE_TAG};