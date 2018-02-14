#!/bin/sh
REPOSITORY_URL=$1;

TAG="${REPOSITORY_URL}-next";
TAG_LATEST="${REPOSITORY_URL}-latest";
VERSION_ROBOTFRAMEWORK="$(pip show robotframework | grep Version | cut -f 2 -d ' ')";
VERSION_SELENIUM2LIBRARY="$(pip show robotframework-selenium2library | grep Version | cut -f 2 -d ' ')";
VERSION_ROBOT_FAKER="$(pip show robotframework-faker | grep Version | cut -f 2 -d ' ')";
VERSION_DATABASELIBRARY="$(pip show robotframework-databaselibrary | grep Version | cut -f 2 -d ' ')";
VERSION_PABOT="$(pip show robotframework-pabot | grep Version | cut -f 2 -d ' ')";
VERSION_PDFMERGE="$(pip show pdfmerge | grep Version | cut -f 2 -d ' ')";
VERSION_FAKER="$(pip show faker | grep Version | cut -f 2 -d ' ')";
VERSION_CHROMEDRIVER="$(chromedriver --version | cut -f 2 -d ' ')"

EXISTENCE_TAG="robotframework-${VERSION_ROBOTFRAMEWORK}_selenium2lib-${VERSION_SELENIUM2LIBRARY}_robotframework-faker-${VERSION_ROBOT_FAKER}_robotframework-databaselibrary-${VERSION_DATABASELIBRARY}_robotframework-pabot-${VERSION_PABOT}_pdfmerge-${VERSION_PDFMERGE}_faker-${VERSION_FAKER}_chromedriver-${VERSION_CHROMEDRIVER}";
EXISTENCE_REPO_URL="${REPOSITORY_URL}-${EXISTENCE_TAG}";
REPO_URL="${REPOSITORY_URL}-${VERSION_AWS}";

printf "Checking existence of [${EXISTENCE_REPO_URL}]...";
$(docker pull ${EXISTENCE_REPO_URL}) && EXISTS=$?;
if [[ "${EXISTS}" = "0" ]]  && [[ "$*" != *"--force"* ]]; then
  printf "[${EXISTENCE_REPO_URL}] found. Skipping push.\n";
  echo exists;
else
  printf "[${EXISTENCE_REPO_URL}] not found. Pushing new image...\n";
  printf "Pushing [${EXISTENCE_REPO_URL}]... ";
  docker tag ${TAG} ${EXISTENCE_REPO_URL};
  docker push ${EXISTENCE_REPO_URL};
  printf "Pushing [${REPO_URL}]... ";
  docker tag ${TAG} ${REPO_URL};
  docker push ${REPO_URL};
  printf "Pushing [${TAG}]... ";
  docker tag ${TAG} ${TAG_LATEST};
  docker push ${TAG_LATEST};
fi;
