FROM ubuntu:bionic

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
build-essential \
libpixman-1-dev \
libpulse-dev \
vde2 \
libvde-dev libvdeplug-dev libvdeplug2 libvde0 python bison flex libcurl4-openssl-dev curl 

workdir /qemu
run curl "https://download.qemu.org/qemu-5.1.0.tar.xz" | tar xJ --strip-components=1

run ./configure  --prefix=/usr/local \
	--target-list="i386-softmmu" 
run make install