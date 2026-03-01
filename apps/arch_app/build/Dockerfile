ARG BASE_IMAGE=zwg.arch_base

FROM ${BASE_IMAGE}

ENV BUILD_ARCHITECTURE=amd64

# x11-utils: contains xdpyinfo, which we use to know whether Xorg has started yet
# pulseaudio-utils: some apps can't play sound unless this package is installed
ARG REQUIRED_PACKAGES="\
    xorg-xdpyinfo \
    pulseaudio \
    mesa mesa-utils vulkan-mesa-layers vulkan-mesa-implicit-layers \
    vulkan-dzn vulkan-tools vulkan-headers vulkan-radeon vulkan-icd-loader vkd3d glu \
    lib32-mesa lib32-mesa-utils lib32-vulkan-mesa-layers lib32-vulkan-mesa-implicit-layers \
    lib32-vulkan-dzn lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-vkd3d lib32-glu \
    noto-fonts \
    glibc-locales \
    gamescope mangohud \
    xorg-xwayland kitty nano \
    waybar awesome-terminal-fonts xdg-desktop-portal xdg-desktop-portal-gtk psmisc \
    "

RUN pacman -Syy --noconfirm && \
    pacman -S \
    $REQUIRED_PACKAGES --noconfirm && \
    pacman -Scc --noconfirm

# Some games with native Linux ports require en_US.UTF-8
# to be generated regardless of user locale settings
# see: https://github.com/games-on-whales/gow/pull/185
RUN locale-gen en_US.UTF-8

COPY configs /cfg

COPY --chmod=777 scripts/init-gamescope.sh /etc/cont-init.d/init-gamescope.sh
COPY --chmod=777 scripts/launch-comp.sh /opt/gow/launch-comp.sh
COPY --chmod=777 scripts/startup.sh /opt/gow/startup.sh
COPY --chmod=777 scripts/wait-x11 /opt/gow/wait-x11
COPY --chmod=777 scripts/startup-app.sh /opt/gow/startup-app.sh
COPY --chmod=755 scripts/hud /usr/bin/hud
# COPY --chmod=755 scripts/seat1 /usr/bin/seat1
# COPY --chmod=755 scripts/seat2 /usr/bin/seat2

RUN mkdir -p ${HOME}/.config && \
    chown -R ${PUID}:${PGID} ${HOME}

COPY --chmod=777 --chown=${PUID}:${PGID} configs/mangohud/MangoHud.conf ${HOME}/.config/MangoHud/MangoHud.conf


# Add /usr/games/ to $PATH in order to be able to run gamescope
ENV PATH="/usr/games/:${PATH}"

#################################
# Install Sway
#################################
# We had lots of issues with Sway 1.10.1
# So we are manually reverting back to 1.9 from Ubuntu 24.04
RUN <<_INSTALL_SWAY
#!/bin/bash
set -e

pacman -S sway foot grim i3status libpulse mako wmenu xorg-xwayland xdg-desktop-portal-gtk xdg-desktop-portal-wlr \
  --noconfirm

_INSTALL_SWAY


# Configure the default directory to be the 'wolf' users home directory
WORKDIR ${HOME}
