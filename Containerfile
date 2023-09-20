FROM fedora:38

RUN dnf -y install \
        rsync \
        git \
        cmake \
        g++  \
        pipewire-devel \
        obs-studio-devel \
        "pkgconfig(pango)" \
        qt6-qtbase-devel

RUN dnf -y install 'dnf-command(copr)'
RUN dnf -y copr enable dherrera/onnx
RUN dnf -y copr enable grillo-delmal/obs-catpion
RUN dnf -y install \
        april-asr-devel

ADD scripts/build.sh /opt/build/build.sh

WORKDIR /opt/build/

CMD ./build.sh
