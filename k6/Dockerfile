FROM cypress/browsers:node14.15.0-chrome96-ff94

LABEL description="Image used for running k6 for load testing"

RUN npm install -g k6
RUN npx k6 install

COPY ./version-info /usr/bin

RUN chmod +x /usr/bin/version-info

RUN npm link $(ls -1 $(npm root -g)/)