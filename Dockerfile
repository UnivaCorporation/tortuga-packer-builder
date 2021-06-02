# Full version needed for cgo
FROM hashicorp/packer:full
ENTRYPOINT [ "/bin/bash", "-c" ]
# Enable upgrade to 3.8 packages for 2.5.x version of ansible
RUN sed -i 's/3\.7/3.8/g' /etc/apk/repositories
# Root operations.  Install packages, create directories
RUN apk update && \
    apk add ansible rsync openssh-client curl jq python3 docker make && \
    mkdir -p /opt && \
    rm -rf /var/cache/apk/*

# Install gcloud
ENV PATH="${PATH}:/opt/google-cloud-sdk/bin"
RUN curl https://sdk.cloud.google.com > install.sh
RUN bash install.sh --disable-prompts --install-dir=/opt
