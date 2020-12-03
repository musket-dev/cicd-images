#!/bin/bash

REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_ANSIBLE=$(printf "%s" "${VERSIONS}" | grep ansible: | cut -f 2 -d ':');
ANSIBLE_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_ANSIBLE}";

printf "Checking existence of [%s]..." "${ANSIBLE_VERSION_REPO_URL}";
_="$(docker pull "${ANSIBLE_VERSION_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[%s] found. Skipping push.\n" "${ANSIBLE_VERSION_REPO_URL}";
  echo exists;
else
  printf "[%s] not found. Pushing new image...\n" "${ANSIBLE_VERSION_REPO_URL}";

  printf "Pushing [%s]... \n" "${TAG_LATEST}";
  docker tag "${TAG}" "${TAG_LATEST}";
  docker push "${TAG_LATEST}";

  printf "Pushing [%s]... \n" "${ANSIBLE_VERSION_REPO_URL}";
  docker tag "${TAG}" "${ANSIBLE_VERSION_REPO_URL}";
  docker push "${ANSIBLE_VERSION_REPO_URL}";
fi;