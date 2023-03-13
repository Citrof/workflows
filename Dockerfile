FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 


LABEL \
  "name"="GitHub Pull Request Action" \
  "homepage"="https://github.com/marketplace/actions/github-pull-request" \
  "repository"="https://github.com/repo-sync/pull-request" \
  "maintainer"="Wei He <github@weispot.com>"

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
apk add --no-cache git hub bash


ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
