FROM busybox AS downloader

ARG CLOUDREVE_VERSION="3.4.2"
ARG ARCH="amd64"

RUN wget -O /tmp/cloudreve.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/${CLOUDREVE_VERSION}/cloudreve_${CLOUDREVE_VERSION}_linux_${ARCH}.tar.gz && \
    tar xvf /tmp/cloudreve.tar.gz -C / && \
    rm -rf /tmp/cloudreve.tar.gz && \
    chown root:root /cloudreve && \
    chmod 755 /cloudreve

FROM debian:bullseye

COPY --from=downloader /cloudreve /usr/local/bin/cloudreve
WORKDIR /cloudreve

CMD [ "/usr/local/bin/cloudreve", "-c", "/cloudreve/config.ini" ]
