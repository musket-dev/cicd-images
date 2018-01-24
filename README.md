# CI/CD Containers for Pipelines

[![Build Status](https://travis-ci.org/GovTechSG/cicd-images.svg?branch=master)](https://travis-ci.org/GovTechSG/cicd-images)

This repository is a collection of Docker images we use internally for continuous integration/delivery pipelines.

Daily builds are run against these images and automatically sent to our DockerHub repository at:

https://hub.docker.com/r/govtechsg/cicd-images

## Catalog (Alphabetical Order)

- Amazon Web Services CLI (`awscli`)
- Docker-in-Docker (`dind`)
- Google Kubernetes Engine CLI (`gkecli`)
- Karma Test Runner (`karma`)
- Node.js (`node`)

### Release Notes

The images are found in the [DockerHub registry](https://hub.docker.com/r/govtechsg/cicd-images), and the names of the different types of images are added as a tag. For example given a type of image called `xyz`, it will be available under the repository URL `govtechsg/cicd-images:xyz-latest`. Specific versions can be found in the [DockerHub Tags page](https://hub.docker.com/r/govtechsg/cicd-images/tags/)

### Usage/Descriptions

#### `awscli`
Canonical Tag: `awscli-<AWS_CLI_VERSION>`  
Latest URL: `govtechsg/cicd-images:awscli-latest`

#### `dind`
Canonical Tag: `dind-<DOCKER_VERSION>`  
Latest URL: `govtechsg/cicd-images:dind-latest`

#### `gkecli`
Canonical Tag: `gkecli-<GOOGLE_SDK_VERSION>`  
Latest URL: `govtechsg/cicd-images:gkecli-latest`

#### `karma`
Canonical Tag: `karma-<CHROMIUM_VERSION>`  
Latest URL: `govtechsg/cicd-images:karma-latest`

#### `node`
Canonical Tag: `node-v<NODE_VERSION>`  
Latest URL: `govtechsg/cicd-images:node-latest`

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