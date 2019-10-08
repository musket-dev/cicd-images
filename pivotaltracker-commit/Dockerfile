FROM ruby:2.4.9-alpine3.10

RUN apk add git
COPY ./commit.rb /

ENTRYPOINT [ "ruby", "commit.rb" ]