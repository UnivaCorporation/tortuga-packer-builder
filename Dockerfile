FROM hashicorp/packer:light
ENTRYPOINT [ "/bin/bash", "-c" ]
RUN apk update && \
    apk add ansible \
    rm -rf /var/cache/apk/*
