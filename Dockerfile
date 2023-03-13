FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 

RUN apk add wget

RUN wget -O /tmp/hub.tgz https://github.com/github/hub/releases/download/v2.15.1/hub-linux-amd64-2.15.1.tgz && \
    tar -xzC /tmp/ -f /tmp/hub.tgz && \
    /tmp/hub-linux-amd64-2.15.1/install && \
    rm -rf /tmp/hub*

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
