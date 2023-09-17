FROM fedora:38

RUN dnf -y install \
        meson \
        ninja-build \
        rsync \
        git \
        cmake \
        g++  \
        libadwaita-devel \
        desktop-file-utils \
        libappstream-glib \
        pipewire-devel \
        obs-studio-devel \
        "pkgconfig(pango)" \
        qt-devel \
        qt6-qtbase-devel \
        qt6-qttools-devel \
        qt6-qtbase-gui

RUN dnf -y install 'dnf-command(copr)'
RUN dnf -y copr enable dherrera/onnx
RUN dnf -y install \
        april-asr-devel

ADD scripts/build.sh /opt/build/build.sh

WORKDIR /opt/build/

CMD ./build.sh
