FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 
    
RUN apk add curl rsync

RUN apk add bash rsync

RUN apk add --no-cache curl git openssh && \
    wget -O /tmp/hub.tgz https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz && \
    tar -xzC /tmp/ -f /tmp/hub.tgz && \
    /tmp/hub-linux-amd64-2.14.2/install && \
    rm -rf /tmp/hub*

ENV PATH="/usr/local/bin:${PATH}"

CMD ["hub", "--version"]

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
