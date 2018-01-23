FROM docker:latest
LABEL maintainer="zephinzer <dev-at-joeir-dot-net>" \
      description="Docker-in-Docker container for use in CI pipelines"
ENV APK_DEPENDENCIES="bash curl git jq openssh build-base python-dev python py-pip" \
    PIP_DEPENDENCIES="docker-compose" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"
WORKDIR ["/"]
COPY ./version-info /usr/bin/
RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && pip --no-cache-dir install ${PIP_DEPENDENCIES} \
    && alias md5='md5sum' \
    && rm -rf ${PATHS_TO_REMOVE} \
    && chmod +x /usr/bin/version-info
ENTRYPOINT ["version-info"]
VOLUME ["/var/run/docker.sock", "/cache"]