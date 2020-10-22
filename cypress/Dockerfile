FROM cypress/browsers:node12.14.1-chrome85-ff81	

LABEL maintainer="jinjie" \
      description="Image used for running Cypress testing framework"

ENV libList mysql \
    mocha mocha-steps mochawesome mochawesome-merge \
    mochawesome-report-generator \
    cypress-eslint-preprocessor \
    cypress-promise \
    cypress-xpath \
    eslint faker fs-extra moment prettier dotenv \
    lodash date-fns 
    
RUN npm install -g $libList

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)
