FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync \
    apk add hub rsync

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
