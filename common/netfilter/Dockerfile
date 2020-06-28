FROM ubuntu:bionic
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
curl build-essential

run curl "https://netfilter.org/pub/iptables/iptables-1.8.2.tar.bz2" -o /tmp/iptables-1.8.2.tar.bz2
workdir /tmp
run tar xf iptables-1.8.2.tar.bz2
workdir iptables-1.8.2
run ./configure --prefix=/usr/local --disable-nftables
run make
run make install


