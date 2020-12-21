FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND="noninteractive"
ARG HYPERHDR_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
ARG HYPERHDR_VERSION="12.1.0.0"
ARG ARCH="x86_64"

#RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list
#RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list
#RUN sed -i "s/security.debian.org/mirrors.aliyun.com\/debian-security/g" /etc/apt/sources.list

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
            wget libusb-1.0-0 libexpat1 libglu1-mesa libglib2.0-0 libfreetype6 && \
 echo "**** install HyperHDR ****" && \
 wget -O /tmp/hyperhdr.deb ${HYPERHDR_URL}/v${HYPERHDR_VERSION}/HyperHDR-${HYPERHDR_VERSION}-Linux-${ARCH}.deb && \
 apt install -y ./tmp/hyperhdr.deb && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8090 19444 19445
VOLUME /config
