# Full version needed for cgo
FROM hashicorp/packer:full
ENTRYPOINT [ "/bin/bash", "-c" ]
# Enable upgrade to 3.8 packages for 2.5.x version of ansible
RUN sed -i 's/3\.7/3.8/g' /etc/apk/repositories 
# Root operations.  Install packages, add builder user, create directories
RUN apk update && \
    apk add ansible rsync openssh-client curl jq python3 docker && \
    adduser -D builder && \
    mkdir -p /opt/google-cloud-sdk && \
    chown -R builder: /opt/google-cloud-sdk && \
    rm -rf /var/cache/apk/*

# Install gcloud
ENV PATH="${PATH}:/opt/google-cloud-sdk/bin"
USER builder
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-226.0.0-linux-x86_64.tar.gz -O /tmp/out.tar.gz && \
    cd /opt && tar xzf /tmp/out.tar.gz && rm /tmp/out.tar.gz && \
    ./google-cloud-sdk/install.sh -q && \
    cd -
