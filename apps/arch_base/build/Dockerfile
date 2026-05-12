# syntax=docker/dockerfile:1.4
FROM archlinux:latest

# Configure default user and set env
# The users UID and GID will be set on container startup
ENV \
    PUID=1000 \
    PGID=1000 \
    UMASK=000 \
    UNAME="retro" \
    HOME="/home/retro" \
    TZ="Europe/Berlin" \
    NEEDRESTART_SUSPEND=1

ARG TARGETARCH="amd64"
ARG TARGETVARIANT=""

# Install default required packages
ARG GOSU_VERSION=1.19

RUN <<_INSTALL_PACKAGES
set -e
echo "**** Activating multilib pacman database ****"
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

echo "**** Update pacman database ****"
pacman -Syy

echo "**** Install certificates ****"
pacman -S --noconfirm ca-certificates

echo "**** Update system ****"
pacman -Syu --noconfirm

echo "**** Install base packages ****"
pacman -S --noconfirm \
    fuse \
    nss \
    wget \
    curl \
    jq \
    openssl \
    sudo \
    git \
    base-devel


echo "**** Install gosu ****"
wget --progress=dot:giga \
    -O /usr/bin/gosu \
    "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${TARGETARCH}${TARGETVARIANT}"
chmod +x /usr/bin/gosu

echo "**** Verify gosu works ****"
gosu nobody true && echo "Working!"

echo "**** Replace bubblewrap with suid version ****"
yes | pacman -S bubblewrap-suid

echo "**** Section cleanup ****"
pacman -Scc --noconfirm

_INSTALL_PACKAGES

# Import overlay
COPY overlay /

# Set entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source=$IMAGE_SOURCE
