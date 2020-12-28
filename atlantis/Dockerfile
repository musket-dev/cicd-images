FROM runatlantis/atlantis
LABEL maintainer="Ryan <ryangohjq.dev-at-gmail-com>" \
      description="Atlantis docker image with customizations"
ENV APK_DEPENDENCIES="curl" \
    PIP_DEPENDENCIES="" \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      /var/cache/apk/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"

RUN apk add --update --upgrade --no-cache ${APK_DEPENDENCIES} \
    && rm -rf ${PATHS_TO_REMOVE} \
    && cd /tmp \
    && curl -LO https://github.com/gruntwork-io/terragrunt/releases/download/$(curl --silent "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /bin/terragrunt \
    && chmod +x /bin/terragrunt

COPY ./version-info /usr/bin
RUN chmod +x /usr/bin/version-info

WORKDIR /