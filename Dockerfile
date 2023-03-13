FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 
    
RUN apk add curl

RUN apk add git openssh-client ca-certificates && \
    curl -sSL https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz | tar -xzC /tmp/ && \
    /tmp/hub-linux-amd64-2.15.1/install && \
    rm -rf /tmp/hub-linux-amd64-2.15.1

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
