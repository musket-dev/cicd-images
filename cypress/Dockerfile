FROM cypress/browsers:node13.6.0-chrome80-ff72

LABEL maintainer="jinjie" \
      description="Image used for running Cypress testing framework"

RUN npm install -g mysql \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-plugin-retries \
                   eslint fs-extra prettier

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link mocha mochawesome mochawesome-merge \
             mochawesome-report-generator \
             fs-extra \
             cypress
