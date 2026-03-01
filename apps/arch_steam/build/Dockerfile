ARG BASE_IMAGE=zwg.arch_app

FROM ${BASE_IMAGE}


WORKDIR /

RUN pacman -Sy

RUN pacman -Syu --noconfirm

ARG REQUIRED_PACKAGES=" \
    steam \
    dbus dbus-units networkmanager bluez zip \
    ibus curl xz zenity file xdg-user-dirs xdg-utils pciutils lsb-release mesa-utils \
    fontconfig lib32-fontconfig freetype2 lib32-freetype2 \
"

RUN pacman -Syy --noconfirm && \
    pacman -S \
    $REQUIRED_PACKAGES --noconfirm --needed && \
    pacman -Scc --noconfirm

RUN touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf

# skip annoying debian dialog
RUN rm /usr/bin/zenity && ln -s /usr/bin/true /usr/bin/zenity

# refresh system font cache. For font warnings on startup see: https://github.com/ValveSoftware/steam-runtime/issues/482
RUN fc-cache -f -v

# create symlink for improved decky loader compatibility
RUN ln -sf "$HOME" /home/deck

COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh
# COPY --chmod=777 scripts/system-services.sh /etc/cont-init.d/system-services.sh
# COPY --chmod=777 steamos-update /usr/bin/steamos-update
# COPY --chmod=777 steamos-update /usr/bin/steamos-polkit-helpers/steamos-update
# COPY --chmod=777 steamos-session-select /usr/bin/steamos-session-select
# COPY --chmod=777 jupiter-biosupdate /usr/bin/jupiter-biosupdate
# COPY --chmod=777 jupiter-biosupdate /usr/bin/steamos-polkit-helpers/jupiter-biosupdate
# COPY --chmod=777 scripts/steamos-dbus-watchdog.sh /usr/local/bin/steamos-dbus-watchdog.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

COPY configs /cfg

COPY --chmod=777 scripts/startup-app.sh /opt/gow/startup-app.sh

# Configure the default directory to be the 'retro' users home directory
WORKDIR ${HOME}
