FROM ubuntu:16.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
curl build-essential

run curl ftp://ftp.netfilter.org/pub/iptables/iptables-1.8.2.tar.bz2 -o /tmp/iptables-1.8.2.tar.bz2
workdir /tmp
run tar xf iptables-1.8.2.tar.bz2
workdir iptables-1.8.2
run ./configure     --prefix=/out     --mandir=/usr/man  --disable-nftables
run make
run make install


