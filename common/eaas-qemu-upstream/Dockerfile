FROM ubuntu:bionic

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
build-essential ninja-build \
libpixman-1-dev \
libpulse-dev \
vde2 \
libvde-dev libvdeplug-dev libvdeplug2 libvde0 python bison flex libcurl4-openssl-dev curl 

workdir /qemu
run curl "https://download.qemu.org/qemu-7.0.0.tar.xz" | tar xJ --strip-components=1

# HACK: Allow long URLs as backing file names
RUN sed -i '/backing_file/s/1023/(PATH_MAX-1)/' block/qcow2.c

# HACK: Increase default timeout for CURL connections
RUN file="block/curl.c"; script='/CURL_BLOCK_OPT_TIMEOUT_DEFAULT/s/5/60/'; \
    sed -E -i.orig -- "$script" "$file" && ! diff -u -- "$file.orig" "$file"

run ./configure  --prefix=/usr/local --disable-user --disable-system --enable-tools 
run make install
