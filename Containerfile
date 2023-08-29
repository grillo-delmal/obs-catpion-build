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
        "pkgconfig(pango)"

ADD scripts/build.sh /opt/build/build.sh

WORKDIR /opt/build/

CMD ./build.sh
