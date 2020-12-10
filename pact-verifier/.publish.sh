#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_RUBY=$(printf "${VERSIONS}" | grep ruby | cut -f 2 -d ':');
VERSION_PACT_VERIFIER=$(printf "${VERSIONS}" | grep pact-provider-verifier | cut -f 2 -d ':');
EXISTENCE_TAG="pact-provider-verifier-${VERSION_PACT_VERIFIER}_ruby-${VERSION_RUBY}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
PACT_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_PACT_VERIFIER}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
_="$(docker pull "${EXISTENCE_REPO_URL}")" && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${PACT_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${PACT_VERSION_REPO_URL};
  docker push ${PACT_VERSION_REPO_URL};
  printf "Pushing [${TAG}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
fi;