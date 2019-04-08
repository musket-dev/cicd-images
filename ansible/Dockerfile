ARG alpine_ver=3.9
FROM alpine:${alpine_ver}
LABEL maintainer="salihan" \
      description="Image containing Ansible and Ansible-lint for use in CI/CD pipelines"

ARG python=3.6.8-r1
ARG openssh_client=7.9_p1-r4
ARG sudo=1.8.25_p1-r2
ARG curl=7.64.0-r1
ARG gcc=8.2.0-r2
ARG zip=3.0-r7
ARG bash=4.4.19-r1
ARG ansible=2.7.0-r1
ARG pip_ver=19.0.3
ARG ansible_lint=4.1.0
ARG boto3_ver=1.9.125
ARG boto2_ver=2.49.0

ENV USERID="1001" \
    GROUPID="1001" \
    PYTHON=${python} \
    OPENSSH_CLIENT=${openssh_client} \
    SUDO=${sudo} \
    CURL=${curl} \
    GCC=${gcc} \
    ZIP=${zip} \
    BASH=${bash} \
    ANSIBLE=${ansible} \
    PIP=${pip_ver} \
    ANSIBLE_LINT=${ansible_lint} \
    BOTO3=${boto3_ver} \
    BOTO2=${boto2_ver}

RUN addgroup -S cicd -g ${GROUPID} \
  && adduser -D -S cicd -u ${USERID} -G cicd \
  && apk update \
  && apk add --no-cache python3=${PYTHON} \
    openssh-client=${OPENSSH_CLIENT} \
    sudo=${SUDO} \
    curl=${CURL} \
    gcc=${GCC} \
    zip=${ZIP} \
    bash=${BASH} \
    ansible=${ANSIBLE} \
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --upgrade pip==${PIP} \
  && pip3 install ansible-lint==${ANSIBLE_LINT} \
  && pip3 install boto3==${BOTO3} \
  && pip3 install boto==${BOTO2} \
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
  && deluser --remove-home postgres \
  && deluser --remove-home vpopmail \
  && deluser --remove-home ntp \
  && deluser --remove-home smmsp \
  && deluser --remove-home guest

  USER cicd