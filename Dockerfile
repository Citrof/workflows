FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 

RUN apk add wget

RUN wget https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz && \
    tar -xf hub-linux-amd64-2.14.2.tgz && \
    rm hub-linux-amd64-2.14.2.tgz && \
    mv hub-linux-amd64-2.14.2/bin/hub /usr/local/bin/ && \
    chmod +x /usr/local/bin/hub

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
