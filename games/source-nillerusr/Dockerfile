FROM        --platform=$TARGETOS/$TARGETARCH debian:stable-slim

LABEL       author="Aru Moon" maintainer="anton17082003@gmail.com"

LABEL       org.opencontainers.image.source="https://github.com/AruMoon/yolks"
LABEL       org.opencontainers.image.licenses=MIT

ENV         DEBIAN_FRONTEND=noninteractive

RUN         dpkg --add-architecture i386 \
				&& apt update \
				&& apt upgrade -y \
				&& apt install -y git gcc gcc-multilib g++ g++-multilib libedit-dev libedit-dev:i386 zlib1g-dev zlib1g-dev:i386 libbz2-dev libbz2-dev:i386 iproute2 python3 python-is-python3 pkg-config \
				&& useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
