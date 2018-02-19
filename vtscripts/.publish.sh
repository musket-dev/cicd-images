#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_VTSCRIPTS=$(printf "${VERSIONS}" | grep -e 'vtscripts:' | cut -f 2 -d ':');
EXISTENCE_TAG="vtscripts-${VERSION_VTSCRIPTS}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
VTSCRIPTS_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_VTSCRIPTS}";

TAG_LATEST="${REPOSITORY_URL}-latest";

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
  printf "Pushing [${VTSCRIPTS_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${VTSCRIPTS_VERSION_REPO_URL};
  docker push ${VTSCRIPTS_VERSION_REPO_URL};
fi;