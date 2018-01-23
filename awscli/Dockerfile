FROM iron/base:3.4
LABEL maintainer="zephinzer <dev-at-joeir-dot-net>" \
      description="Amazon Web Services CLI image for use in CI pipelines"
ENV APK_DEPENDENCIES="bash curl git jq python py-pip make docker" \
    PIP_DEPENDENCIES="awscli" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"
COPY ./version-info /usr/bin/
RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && pip install --upgrade pip \
    && pip --no-cache-dir install ${PIP_DEPENDENCIES} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && chmod +x /usr/bin/version-info
WORKDIR ["/"]
ENTRYPOINT ["version-info"]