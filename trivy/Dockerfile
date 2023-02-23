ARG TRIVY_VERSION="latest"
FROM aquasec/trivy:${TRIVY_VERSION}
LABEL maintainer="chen_shaorong@tech.gov.sg" \
      description="Image used for running trivy tasks that need to retrieve ecr login in the CI pipeline"
ENV APK_DEPENDENCIES="aws-cli"

COPY ./version-info /usr/bin/
RUN apk --no-cache update && apk --no-cache upgrade \
    && apk add --no-cache ${APK_DEPENDENCIES} \
    && chmod +x /usr/bin/version-info \