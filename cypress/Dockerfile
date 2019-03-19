FROM cypress/browsers:latest
LABEL maintainer="jinjie" \
   description="Image used for running Cypress testing framework"
RUN npm i cypress -g
RUN npm install mysql -g
RUN npm install mocha -g
RUN npm install mochawesome -g
RUN npm install cypress-eslint-preprocessor -g
RUN npm install cypress-promise -g
RUN npm install cypress-plugin-retries -g
RUN npm install eslint -g
RUN npm install prettier -g
COPY ./version-info /usr/bin
RUN chmod +x /usr/bin/version-info
