#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_TRIVY=$(printf "${VERSIONS}" | grep trivy | cut -f 2 -d ':');
VERSION_AWS=$(printf "${VERSIONS}" | grep aws | cut -f 2 -d ':');
TRIVY_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_TRIVY}-${VERSION_AWS}";

printf "Checking existence of [${TRIVY_VERSION_REPO_URL}]...";
_="$(docker pull "${TRIVY_VERSION_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${TRIVY_VERSION_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${TRIVY_VERSION_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${TAG_LATEST}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
  printf "Pushing [${TRIVY_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${TRIVY_VERSION_REPO_URL};
  docker push ${TRIVY_VERSION_REPO_URL};
fi;