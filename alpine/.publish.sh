#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_ALPINE=$(printf "${VERSIONS}" | grep alpine | cut -f 2 -d ':');
VERSION_GIT=$(printf "${VERSIONS}" | grep git | cut -f 2 -d ':');
EXISTENCE_TAG="alpine-${VERSION_ALPINE}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
ALPINE_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_ALPINE}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${ALPINE_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${ALPINE_VERSION_REPO_URL};
  docker push ${ALPINE_VERSION_REPO_URL};
fi;