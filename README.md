# CI/CD Containers for Pipelines

[![Build Status](https://travis-ci.org/GovTechSG/cicd-images.svg?branch=master)](https://travis-ci.org/GovTechSG/cicd-images)

This repository is a collection of Docker images we use internally for continuous integration/delivery pipelines.

Daily builds are run against these images and automatically sent to our DockerHub at:

https://hub.docker.com/r/govtechsg/cicd-images

## Catalog (Alphabetical Order)

- Amazon Web Services CLI (`awscli`)
- Docker-in-Docker (`dind`)

## Other Uses
Images specified here can be uploaded to other repositories if you so wish. The commands are:

### For Building
The build script creates the build for the specified image:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

An example to upload to a DockerHub at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./.scripts/.build.sh "${DH_REPO}" "${IMAGE_NAME}"
```

### For Publishing
The publish script in each directory sends your built image to DockerHub and relies on the `./.scripts/.build.sh` script being run prior to it. The general format of usage:

```bash
DH_REPO=__URL_TO_REPO__
IMAGE_NAME=__DIRECTORY_NAME__
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

A corresponding example to upload to a DockerHub repository at `yourusername/yourimage:dind-latest`:

```bash
DH_REPO="yourusername/yourimage"
IMAGE_NAME="dind"
./${IMAGE_NAME}/.publish.sh "${DH_REPO}:${IMAGE_NAME}"
```

Each directory and type of image has its own publish script because of the different ways they are versioned.