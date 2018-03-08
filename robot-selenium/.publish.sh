#!/bin/sh
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";
VERSIONS=$(docker run --entrypoint="version-info" ${TAG});
VERSION_ROBOTFRAMEWORK=$(printf "${VERSIONS}" | grep robotframework-lib | cut -f 2 -d ':');
VERSION_SELENIUM2LIBRARY=$(printf "${VERSIONS}" | grep robotframework-selenium2library | cut -f 2 -d ':');
VERSION_ROBOT_FAKER=$(printf "${VERSIONS}" | grep robotframework-faker | cut -f 2 -d ':');
VERSION_DATABASELIBRARY=$(printf "${VERSIONS}" | grep robotframework-databaselibrary | cut -f 2 -d ':');
VERSION_PABOT=$(printf "${VERSIONS}" | grep robotframework-pabot | cut -f 2 -d ':');
VERSION_PDFMERGE=$(printf "${VERSIONS}" | grep pdfmerge | cut -f 2 -d ':');
VERSION_FAKER=$(printf "${VERSIONS}" | grep faker-lib | cut -f 2 -d ':');
VERSION_CHROMEDRIVER=$(printf "${VERSIONS}" | grep chromedriver | cut -f 2 -d ':')
VERSION_CHROME=$(printf "${VERSIONS}" | grep chrome: | cut -f 2 -d ':')

EXISTENCE_TAG="robot-${VERSION_ROBOTFRAMEWORK}_selenium2lib-${VERSION_SELENIUM2LIBRARY}_rbf-faker-${VERSION_ROBOT_FAKER}-dblib-${VERSION_DATABASELIBRARY}-pabot-${VERSION_PABOT}-chrome-${VERSION_CHROME}_chromedriver-${VERSION_CHROMEDRIVER}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";

printf "Version Tag: ${EXISTENCE_TAG}"

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
  printf "Pushing [${TAG}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
fi;
