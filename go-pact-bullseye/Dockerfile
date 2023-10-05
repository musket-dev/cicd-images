ARG GOLANG_MAJOR_VERSION="1.21"
FROM golang:${GOLANG_MAJOR_VERSION}-bullseye

WORKDIR /opt

ARG PACT_RUBY_STANDALONE_VERSION="2.0.7"
RUN curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/v$PACT_RUBY_STANDALONE_VERSION/pact-$PACT_RUBY_STANDALONE_VERSION-linux-x86_64.tar.gz
RUN tar xzf pact-$PACT_RUBY_STANDALONE_VERSION-linux-x86_64.tar.gz

ENV PATH="/opt/pact/bin:${PATH}"
COPY ./version-info /usr/bin/
RUN chmod +x /usr/bin/version-info
WORKDIR /go/src

