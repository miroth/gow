ARG BASE_IMAGE=zwg.arch_app

FROM ${BASE_IMAGE}


ENV BUILD_ARCHITECTURE=amd64
ARG HEROIC_VERSION=2.21.0

WORKDIR /

RUN pacman -Sy

RUN pacman -Syu --noconfirm

RUN git clone https://aur.archlinux.org/http-parser.git && \
  chmod -R 777 http-parser && \
  useradd -m aur_helper && \
  cd http-parser && \
  su aur_helper makepkg && \
  pacman -U http-parser-2.9.4-2-x86_64.pkg.tar.zst --noconfirm && \
  userdel -f aur_helper

RUN wget https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v$HEROIC_VERSION/Heroic-$HEROIC_VERSION-linux-x64.pacman && \
  pacman -Ud Heroic-$HEROIC_VERSION-linux-x64.pacman --noconfirm  && \
  rm Heroic-$HEROIC_VERSION-linux-x64.pacman
  
RUN pacman -S lutris --noconfirm

ARG REQUIRED_PACKAGES=" \
  wine wine-gecko wine-mono v4l-utils unixodbc sdl2 pcsclite opencl-icd-loader \
  libxinerama libxcomposite libpulse libgphoto2 gst-plugins-good gst-plugins-base-libs gst-plugins-base \
  gnutls ffmpeg dosbox alsa-plugins alsa-lib \
  flac \
"

RUN pacman -Syy --noconfirm && \
    pacman -S \
    $REQUIRED_PACKAGES --noconfirm --needed && \
    pacman -Scc --noconfirm

COPY configs /cfg

COPY --chmod=777 scripts/startup-app.sh /opt/gow/startup-app.sh

# Configure the default directory to be the 'retro' users home directory
WORKDIR ${HOME}
