#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_ALPINE=$(printf "${VERSIONS}" | grep alpine | cut -f 2 -d ':');
ALPINE_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_ALPINE}";

printf "Checking existence of [${ALPINE_VERSION_REPO_URL}]...";
_="$(docker pull "${ALPINE_VERSION_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${ALPINE_VERSION_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${ALPINE_VERSION_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${ALPINE_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${ALPINE_VERSION_REPO_URL};
  docker push ${ALPINE_VERSION_REPO_URL};
fi;