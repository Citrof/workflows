FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 

RUN apk add hub


ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
