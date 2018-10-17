FROM ubuntu:xenial

RUN apt-get update -qq && apt-get install -qq \
                gcc-multilib
ARG CC=gcc
ARG ENV1=FOOBAR

RUN apt-get update && apt-get install -y \
                build-essential \
                protobuf-c-compiler \
                libprotobuf-c0-dev \
                libprotobuf-dev \
                bsdmainutils \
                protobuf-compiler \
                python-minimal \
                libaio-dev \
                libcap-dev \
                iptables \
                libnl-3-dev \
                libnl-route-3-dev \
                libselinux-dev \
                pkg-config \
                git-core \
                libnet-dev \
                ccache \
                $CC

run mkdir /criu
add https://github.com/checkpoint-restore/criu/archive/v3.10.tar.gz /criu
WORKDIR /criu
RUN tar -xf v3.10.tar.gz
WORKDIR /criu/criu-3.10

ENV CC="ccache $CC" CCACHE_DIR=/tmp/.ccache CCACHE_NOCOMPRESS=1 $ENV1=yes

RUN make mrproper && ccache -s && \
# Check single object build
        make -j $(nproc) CC="$CC" criu/parasite-syscall.o && \
# Compile criu
        make -j $(nproc) CC="$CC" && \
        date 

RUN cp /criu/criu-3.10/criu/criu /usr/local/bin/criu

