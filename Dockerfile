# Full version needed for cgo
FROM hashicorp/packer:full
ENTRYPOINT [ "/bin/bash", "-c" ]
RUN apk update && \
    apk add ansible rsync && \
    adduser -D builder && \
    rm -rf /var/cache/apk/*
USER builder
