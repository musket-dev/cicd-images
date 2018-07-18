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
- Kubernetes Client (`kubectl`)
- Trinity (`awscli` + `docker` + `kubectl`)
- Node.js (`node`)
- Robot Selenium (`robot-selenium`)
- Version Tagging Scripts (`vtscripts`)

### Release Notes
The images are found in the [DockerHub registry](https://hub.docker.com/r/govtechsg/cicd-images), and the names of the different types of images are added as a tag. For example given a type of image called `xyz`, it will be available under the repository URL `govtechsg/cicd-images:xyz-latest`. Specific versions can be found in the [DockerHub Tags page](https://hub.docker.com/r/govtechsg/cicd-images/tags/)

### Universal Tooling
All images will contain some tools essential for most operations that will happen in a continuous integration/delivery pipeline. These tools are:

- `bash`
- `curl`
- `jq`
- `vim`
- `git`

### Usage/Descriptions

#### `alpine`
[![Anchore Image Overview](https://anchore.io/service/badges/image/1ceaf7691d3850560b5688794d50861239b6b16cd2042b6d6e0844d2c336e455)](https://anchore.io/preview/dockerhub/govtechsg%2Fcicd-images%3Aalpine-latest)

Canonical Tag: `alpine-<ALPINE_VERSION>`  
Latest URL: `govtechsg/cicd-images:alpine-latest`

##### Notes
We use Alpine for our production deployments, only makes sense to run stuff in Alpine. This image contains common tools in pipelines and should serve most general needs. If you need more pacakges, feel free to submit a pull request with the required APK packages.

#### `awscli`
[![Anchore Image Overview](https://anchore.io/service/badges/image/92f57e60caf542f7a265059daa41c743d9008c897ea146f36a409df48d4058f1)](https://anchore.io/image/dockerhub/92f57e60caf542f7a265059daa41c743d9008c897ea146f36a409df48d4058f1?repo=govtechsg%2Fcicd-images&tag=awscli-latest)

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

#### `dephash`
Canonical Tag: `dephash-<REPO_VERSION>`  
Latest URL: `govtechsg/cicd-images:dephash-latest`

##### Notes
See https://github.com/govtechsg/version-tagging-scripts for more information on using this. Commands are symbolic linked to the system variable directory so you can use the following commands:

- `dephash ./path/to/file --npm`
- `dephash ./path/to/file --npm --prod`
- `dephash ./path/to/file --npm --dev`
- `dephash ./path/to/file --yarn`

#### `dind`
[![Anchore Image Overview](https://anchore.io/service/badges/image/e595de9a2f9534bad0aa758637c4a3e63277402297f6dfc660fa0b9383ff84bb)](https://anchore.io/image/dockerhub/e595de9a2f9534bad0aa758637c4a3e63277402297f6dfc660fa0b9383ff84bb?repo=govtechsg%2Fcicd-images&tag=dind-latest)

Canonical Tag: `dind-<DOCKER_VERSION>`  
Latest URL: `govtechsg/cicd-images:dind-latest`

##### Notes
You will need to configure this image so that the host file at path `/var/run/docker.sock` is mapped to the `/var/run/docker.sock` in the container.

- https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
- https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/
- https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci

#### `gkecli`
[![Anchore Image Overview](https://anchore.io/service/badges/image/ccc9d7e61d0d7ba0c02c76e91434ffe0f8fd3e7dff74ee10cf653873198b5262)](https://anchore.io/image/dockerhub/ccc9d7e61d0d7ba0c02c76e91434ffe0f8fd3e7dff74ee10cf653873198b5262?repo=govtechsg%2Fcicd-images&tag=gkecli-latest)

Canonical Tag: `gkecli-<GOOGLE_SDK_VERSION>`  
Latest URL: `govtechsg/cicd-images:gkecli-latest`

##### Notes
An additional child image, or a script should be added to this to set Google credentials and retrieve the Kubernetes configurations.

- https://cloud.google.com/kubernetes-engine/docs/quickstart

#### `karma`
[![Anchore Image Overview](https://anchore.io/service/badges/image/e71cf4dedbb3f98d164c1b39c13ecb65f1df46ca2172ff5a1c788ac9f0dd6828)](https://anchore.io/image/dockerhub/e71cf4dedbb3f98d164c1b39c13ecb65f1df46ca2172ff5a1c788ac9f0dd6828?repo=govtechsg%2Fcicd-images&tag=karma-latest)

Canonical Tag: `karma-<CHROMIUM_VERSION>`  
Latest URL: `govtechsg/cicd-images:karma-latest`

##### Notes
Karma is not included in the `karma` image, this image only provides the base for it to run ChromeHeadless. Remember to include the `--no-sandbox` flag in the Karma configuration.

#### `kubectl`
[![Anchore Image Overview](https://anchore.io/service/badges/image/5b7aa7d94f99117237888532d546cad600aae49afc63769190bea52e85a6a302)](https://anchore.io/image/dockerhub/5b7aa7d94f99117237888532d546cad600aae49afc63769190bea52e85a6a302?repo=govtechsg%2Fcicd-images&tag=kubectl-latest)

Canonical Tag: `kubectl-<KUBECTL_VERSION>`  
Latest URL: `govtechsg/cicd-images:kubectl-latest`

##### Notes
For use when there's a deployment to a Kubernetes deployment.

#### `node`
[![Anchore Image Overview](https://anchore.io/service/badges/image/b57dcf8f428ef90f551b75935c621a44925f68aa52f9d4394e0a6ad05cc0a30d)](https://anchore.io/image/dockerhub/b57dcf8f428ef90f551b75935c621a44925f68aa52f9d4394e0a6ad05cc0a30d?repo=govtechsg%2Fcicd-images&tag=node-latest)

Canonical Tag: `node-<NODE_VERSION>`  
Latest URL: `govtechsg/cicd-images:node<NODE_MAJOR_VERSION>-latest`

##### Notes
All LTS versions of Node, and the latest major version (LTS or otherwise) are builit.

- https://github.com/nodejs/Release

#### `robot-selenium`
[![Anchore Image Overview](https://anchore.io/service/badges/image/cab737500036d300fe203a19f78fa9e4a4a49fa53e9b4a4190c1c700d10bc3fc)](https://anchore.io/image/dockerhub/cab737500036d300fe203a19f78fa9e4a4a49fa53e9b4a4190c1c700d10bc3fc?repo=govtechsg%2Fcicd-images&tag=robot-selenium-latest)

Latest URL: `govtechsg/cicd-images:robot-selenium-latest`

#### `trinity`

Canonical Tag: `trinity-<AWS_CLI_VERSION>-<DOCKER_VERSION>-<KUBECT_VERSION>`
Latest URL: `govtechsg/cicd-images:trinity-latest`

#### `vtscripts`
[![Anchore Image Overview](https://anchore.io/service/badges/image/67d5a49c09e43b95468a4bd4488d02125981013180af3733532977fdaa283ed2)](https://anchore.io/image/dockerhub/67d5a49c09e43b95468a4bd4488d02125981013180af3733532977fdaa283ed2?repo=govtechsg%2Fcicd-images&tag=vtscripts-latest)

Canonical Tag: `vtscripts-<VTSCRIPTS>`
Latest URL: `govtechsg/cicd-images:vtscripts-latest`

##### Notes
See https://github.com/govtechsg/version-tagging-scripts for more information on using this. Commands are symbolic linked to the system variable directory so you can use the following commands:

- `init -q`
- `get-branch -q`
- `get-latest -q`
- `get-next -q`
- `iterate -q`

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
