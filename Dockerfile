# Full version needed for cgo
FROM hashicorp/packer:full
ENTRYPOINT [ "/bin/bash", "-c" ]
RUN apk update && \
    apk add ansible \
    rm -rf /var/cache/apk/*
