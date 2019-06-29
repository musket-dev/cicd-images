ARG NODE_VERSION="12-slim"
FROM node:${NODE_VERSION}
LABEL maintainer="gyl <gylswork@gmail.com>" \
      description="Image used for running tasks which require chromium e.g. Lighthouse"
ENV APT_DEPENDENCIES="google-chrome-stable chromedriver python3 python3-pip vim jq curl yarn" \
    PIP_DEPENDENCIES="awscli" \
    YARN_DEPENDENCIES="lighthouse" \
    CHROME_PATH=/usr/bin/google-chrome-stable \
    PATHS_TO_REMOVE="\
      /usr/include/* \
      /usr/share/man/* \
      ~/.cache/pip/* \
      /var/cache/misc/*"
USER root
WORKDIR /app
COPY ./version-info /usr/bin/
RUN apt-get -y update --fix-missing && apt-get -y upgrade \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -y update \
    && apt-get -y install ${APT_DEPENDENCIES}

RUN pip3 install ${PIP_DEPENDENCIES} \
    && yarn global add ${YARN_DEPENDENCIES} \
    && chmod +x /usr/bin/version-info \
    && rm -rf ${PATHS_TO_REMOVE} \
    && ln -s /usr/bin/google-chrome-stable /usr/bin/chrome \
    && useradd -d /app app \
    && chown -R app /app

USER app
