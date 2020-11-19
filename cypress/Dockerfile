FROM cypress/browsers:node14.15.0-chrome86-ff82

LABEL maintainer="jinjie" \
      description="Image used for running Cypress testing framework"
    
RUN npm install -g cypress mysql \
                   mocha mocha-steps mochawesome mochawesome-merge \
                   mochawesome-report-generator \
                   cypress-eslint-preprocessor \
                   cypress-promise \
                   cypress-xpath \
                   eslint faker fs-extra moment prettier dotenv \
                   lodash date-fns 

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)
