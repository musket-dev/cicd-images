# CI/CD Containers for Pipelines

[![Build Status](https://travis-ci.org/GovTechSG/cicd-images.svg?branch=master)](https://travis-ci.org/GovTechSG/cicd-images)

This repository is a collection of Docker images we use internally for continuous integration/delivery pipelines.

Daily builds are run against these images and automatically sent to our DockerHub repository at:

https://hub.docker.com/r/govtechsg/cicd-images

## Catalog (Alphabetical Order)

- Alpine Linux (`alpine`)
- Amazon Web Services CLI (`awscli`)
- Docker-in-Docker (`dind`)
- Google Kubernetes Engine CLI (`gkecli`)
- Karma Test Runner (`karma`)
- Node.js (`node`)

### Release Notes

The images are found in the [DockerHub registry](https://hub.docker.com/r/govtechsg/cicd-images), and the names of the different types of images are added as a tag. For example given a type of image called `xyz`, it will be available under the repository URL `govtechsg/cicd-images:xyz-latest`. Specific versions can be found in the [DockerHub Tags page](https://hub.docker.com/r/govtechsg/cicd-images/tags/)

### Usage/Descriptions

#### `alpine`
Canonical Tag: `alpine-<ALPINE_VERSION>`  
Latest URL: `govtechsg/cicd-images:alpine-latest`

##### Notes
We use Alpine for our production deployments, only makes sense to run stuff in Alpine. This image contains common tools in pipelines and should serve most general needs. If you need more pacakges, feel free to submit a pull request with the required APK packages.

#### `awscli`
Canonical Tag: `awscli-<AWS_CLI_VERSION>`  
Latest URL: `govtechsg/cicd-images:awscli-latest`

##### Notes
Set the following environment variables to your AWS credentials to allow the AWS CLI tool to connect.

```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
```

- https://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html

#### `dind`
Canonical Tag: `dind-<DOCKER_VERSION>`  
Latest URL: `govtechsg/cicd-images:dind-latest`

##### Notes
You will need to configure this image so that the host file at path `/var/run/docker.sock` is mapped to the `/var/run/docker.sock` in the container.

- https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
- https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/
- https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci

#### `gkecli`
Canonical Tag: `gkecli-<GOOGLE_SDK_VERSION>`  
Latest URL: `govtechsg/cicd-images:gkecli-latest`

##### Notes
An additional child image, or a script should be added to this to set Google credentials and retrieve the Kubernetes configurations.

- https://cloud.google.com/kubernetes-engine/docs/quickstart

#### `karma`
Canonical Tag: `karma-<CHROMIUM_VERSION>`  
Latest URL: `govtechsg/cicd-images:karma-latest`

##### Notes
Karma is not included in the `karma` image, this image only provides the base for it to run ChromeHeadless. Remember to include the `--no-sandbox` flag in the Karma configuration.

#### `node`
Canonical Tag: `node-<NODE_VERSION>`  
Latest URL: `govtechsg/cicd-images:node<NODE_MAJOR_VERSION>-latest`

##### Notes
All LTS versions of Node, and the latest major version (LTS or otherwise) are builit.

- https://github.com/nodejs/Release

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