#!/bin/bash
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";

VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_NODE=$(printf "${VERSIONS}" | grep -e 'node:' | cut -f 2 -d ':');
VERSION_NODE_MAJOR=$(printf "${VERSIONS}" | grep -e 'node_major:' | cut -f 2 -d ':');
VERSION_NODE_MINOR=$(printf "${VERSIONS}" | grep -e 'node_minor:' | cut -f 2 -d ':');
VERSION_NODE_PATCH=$(printf "${VERSIONS}" | grep -e 'node_patch:' | cut -f 2 -d ':');
VERSION_NPM=$(printf "${VERSIONS}" | grep npm | cut -f 2 -d ':');
VERSION_YARN=$(printf "${VERSIONS}" | grep yarn | cut -f 2 -d ':');
EXISTENCE_TAG="node-${VERSION_NODE}_npm-${VERSION_NPM}_yarn-${VERSION_YARN}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
NODE_VERSION_REPO_URL="${REPOSITORY_URL}-${VERSION_NODE}";

TAG_LATEST="${REPOSITORY_URL}${VERSION_NODE_MAJOR}-latest";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
$(docker pull ${EXISTENCE_REPO_URL}) && EXISTS=$?;
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
  printf "Pushing [${NODE_VERSION_REPO_URL}]... ";
  docker tag ${TAG} ${NODE_VERSION_REPO_URL};
  docker push ${NODE_VERSION_REPO_URL};
fi;