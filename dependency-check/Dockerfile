FROM owasp/dependency-check:latest
USER root
RUN /usr/share/dependency-check/bin/dependency-check.sh --updateonly

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

USER 1000

ENTRYPOINT [ "/usr/share/dependency-check/bin/dependency-check.sh"]