# Full version needed for cgo
FROM hashicorp/packer:full
ENTRYPOINT [ "/bin/bash", "-c" ]
# Root operations.  Install packages, add builder user, create directories
RUN apk update && \
    apk add ansible rsync openssh-client curl && \
    adduser -D builder && \
    mkdir -p /opt/google-cloud-sdk && \
    chown -R builder: /opt/google-cloud-sdk && \
    rm -rf /var/cache/apk/*
USER builder
# Install gcloud
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-209.0.0-linux-x86_64.tar.gz -O /tmp/out.tar.gz && \
    cd /opt && tar xzf /tmp/out.tar.gz && rm /tmp/out.tar.gz && \
    ./google-cloud-sdk/install.sh --path-update true -q && \
    cd -
