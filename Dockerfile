ARG CLOUDREVE_VERSION="3.4.2"
ARG ARCH="amd64"

FROM busybox AS downloader
RUN wget -O  /tmp/cloudreve.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/${CLOUDREVE_VERSION}/cloudreve_${CLOUDREVE_VERSION}_linux_${ARCH}.tar.gz /tmp/cloudreve.tar.gz && \
    tar xvf /tmp/cloudreve.tar.gz -C /usr/local/bin && \
    rm -rf /tmp/cloudreve.tar.gz && \
    chown root:root /usr/local/bin/cloudreve && \
    chmod 755 /usr/local/bin/cloudreve

FROM debian:bullseye

COPY --from=downloader /usr/local/bin/cloudreve /usr/local/bin/cloudreve
WORKDIR /cloudreve

CMD [ "/usr/local/bin/cloudreve", "-c", "/cloudreve/config.ini" ]
