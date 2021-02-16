ARG alpine_ver=3.13.1
FROM alpine:${alpine_ver}
LABEL maintainer="salihan" \
      description="Image containing Ansible and Ansible-lint for use in CI/CD pipelines"

ARG user=cicd
ARG group=cicd

COPY ./version-info /usr/bin

ENV USERID="1101" \
  GROUPID="1101" \
  USER=${user} \
  GROUP=${group}

RUN addgroup -S ${GROUP} -g ${GROUPID} \
  && adduser -D -S ${USER} -u ${USERID} -G ${GROUP} \
  && apk update \
  && apk add --no-cache python3 \
    openssh-client \
    sudo \
    curl \
    gcc \
    zip \
    bash \
    ansible \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --upgrade pip \
  && pip3 install ansible-lint \
  && pip3 install boto3 \
  && pip3 install boto \
  && ln -s /usr/bin/python3 /usr/bin/python \
  && rm -rf /usr/share/man/* \
    /usr/includes/* \
    /var/cache/apk/* \
  && deluser --remove-home daemon \
  && deluser --remove-home adm \
  && deluser --remove-home lp \
  && deluser --remove-home sync \
  && deluser --remove-home shutdown \
  && deluser --remove-home halt \
  && deluser --remove-home postmaster \
  && deluser --remove-home cyrus \
  && deluser --remove-home mail \
  && deluser --remove-home news \
  && deluser --remove-home uucp \
  && deluser --remove-home operator \
  && deluser --remove-home man \
  && deluser --remove-home cron \
  && deluser --remove-home ftp \
  && deluser --remove-home sshd \
  && deluser --remove-home at \
  && deluser --remove-home squid \
  && deluser --remove-home xfs \
  && deluser --remove-home games \
  && deluser --remove-home vpopmail \
  && deluser --remove-home ntp \
  && deluser --remove-home smmsp \
  && deluser --remove-home guest

USER ${USER}