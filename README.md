# docker-hyperdr

## Overview
Uses [Awawa's HDR edit for hyperion-ng](https://github.com/awawa-dev/HyperHDR/releases) to create docker image

Requires host OS to have drivers (DVB or otherwise) to pick up the device and share it to docker, it has been tested and working on Unraid with 6.9 rc2 w/ DVB plugins using openelec drivers and a USB grabber. Others most likely won't be tested right now.

Possible future (because it's already working for me and not sure if I want to go further)
1. Home Assistant Add-on
2. Docker Hub upload with multi-architecture support

## Running
- Clone repo 
- Build docker image 
  ```
  docker build -t hyper-hdr .
  ```
- Run the container
  ```bash
  docker run -d \
    --name=hyperhdr \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -e UMASK_SET=022 `#optional` \
    -p=8090:8090 \
    -p=19445:19445 \
    -p=19444:19444 \
    -v /path/to/data:/config \
    --restart=unless-stopped \
    hyper-hdr
  ```
- Docker-Compose Example (This is what I use on Unraid)
  ```
  ---
  version: '2'

  services:

    hyper-hdr:
      container_name: hyper-hdr
      hostname: hyper-hdr
      image: hyper-hdr:latest
      devices:
        - /dev/video0
      ports:
        - "8090:8090"
        - "19445:19445"
        - "19444:19444"
      environment:
        - PUID=99
        - PGID=100
        - TZ=Europe/London
      volumes:
        - path/to/appdata/hyper-hdr:/config
      restart: unless-stopped
  ```

Originally based on https://github.com/malalam/docker-hyper-hdr so big thanks to malalam
Lots of re-used images from linuxserver.io as well in an attempt to keep everything normalized and learn what they're using!

