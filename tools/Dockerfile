FROM bash:5.3

RUN apk add --no-cache \
    curl \
    wget \
    jq \
    bc \
    openssl \
    coreutils \
    libfaketime

ADD bin/mktemp /usr/local/bin/mktemp

ENV LD_PRELOAD=/usr/lib/faketime/libfaketime.so.1
ENV FAKETIME="2025-01-01 10:00:00"
ENV FAKETIME_NO_CACHE=1
ENV HOSTNAME=shellbyexample
