FROM        --platform=$TARGETOS/$TARGETARCH debian:bullseye-slim

LABEL       author="Aru Moon" maintainer="anton17082003@gmail.com"

LABEL       org.opencontainers.image.source="https://github.com/AruMoon/yolks"
LABEL       org.opencontainers.image.licenses=MIT

ENV         DEBIAN_FRONTEND=noninteractive

RUN         dpkg --add-architecture i386 \
				&& apt update \
				&& apt upgrade -y \
				&& apt -y --no-install-recommends install ca-certificates curl lib32gcc-s1 libsdl2-2.0-0:i386 git wget zip unzip gcc gcc-multilib g++ g++-multilib libedit-dev libedit-dev:i386 zlib1g-dev zlib1g-dev:i386 python3 python-is-python3 pkg-config
