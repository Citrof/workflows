FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add git rsync 
    
RUN apk add curl rsync

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
