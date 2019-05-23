# create eaas-base 
# using: https://github.com/phusion/baseimage-docker

FROM phusion/baseimage:0.9.22
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y

## init bwfla repo
COPY files/bwfla.list /etc/apt/sources.list.d/bwfla.list
COPY files/pin-bwfla.pref /etc/apt/preferences.d/pin-bwfla.pref

run apt-add-repository ppa:fengestad/stable

#mongo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

#siegfried
run echo "deb http://dl.bintray.com/siegfried/debian wheezy main" | tee -a /etc/apt/sources.list
RUN add-apt-repository ppa:projectatomic/ppa

RUN rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
bindfs \
hatari \
beebem \
kegs-sdl \
vice-sdl \
basilisk2 \
pce-atari-st \
pce-atari-st-data \
pce-dos \
pce-ibmpc \
pce-ibmpc-data \
pce-macplus \
pce-macplus-data \
pce-utils \
dosbox \
guacd \
libguac-client-sdlonp0 \
libsdl1.2debian \
qemu-utils \
qemu-system-x86 \
qemu-system-ppc \
sheepshaver \
libcurl3 \
libcurl3-gnutls \
qemu-block-extra \
xmount \
libxmount-input-qemu \
debconf-utils \
pmount \
mkisofs \
fuseiso \
dosfstools \
hfsutils \
ntfs-3g \
parted \
hfsprogs \
cabextract \
chntpw \
zip \
fs-uae \
fs-uae-launcher \
fs-uae-arcade \
apache2 \
libfaketime \
vde2 \
dbus-x11 \
python-pip \
python-dev \
build-essential \
python3-gi \
python3-click \
python3-gi-cairo \
python3-cairo \
gir1.2-gtk-3.0 \
python-netifaces \
python-avahi \
nghttp2-proxy \ 
pulseaudio \
sudo \
jq \
git \
ghostscript \
openjdk-8-jre-headless \
libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler python-protobuf libnl-3-dev libnet-dev \
socat \
mongodb-org \
siegfried \
skopeo \ 
wget jq bsdtar squashfs-tools  libgpgme11-dev libassuan-dev btrfs-tools libdevmapper-dev git pkg-config libglib2.0-dev -y && apt-get clean && apt-get autoremove
#libguestfs-tools \
#linux-image-generic 

#VisualBoy is installed in differnt layer, because the previous step is too big for docker to handle
RUN apt-get install visualboyadvance

#RUN pip install neovim-gui

RUN sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf

RUN rm -rf /usr/lib/xmount/libxmount_input_aff.so

## prepare the system to host sheepshaver
COPY files/init-scripts/ /etc/my_init.d/

add files/vice-data/opt /opt
add files/amiga /opt/amiga

# allow loop devices to be mounted by users
#COPY files/pmount.allow /etc/pmount.allow

## prepare services
COPY files/service /etc/service/

## prepare services
COPY files/sudoers/citar-passwordless-commands /etc/sudoers.d/citar-passwordless-commands

#apache config
COPY files/apache-sites /etc/apache2/sites-available/
RUN a2ensite demo-ui && a2enmod proxy_http proxy_wstunnel rewrite headers
COPY files/ports.conf /etc/apache2/ports.conf

# nghttpx config
COPY files/nghttpx/ /etc/nghttpx/
# dns & ssl scripts
COPY files/libexec/ /libexec/

# copy tools and scripts
COPY files/binaries/ /usr/bin/

#lklfuse
copy --from=registry.gitlab.com/emulation-as-a-service/lklfuse /opt/lkl/lklfuse /usr/bin/
#copy --from=registry.gitlab.com/emulation-as-a-service/lklfuse:chown-symlink /opt/lkl/lklfuse /usr/bin/

COPY files/lib/ /usr/local/lib/

RUN addgroup --gid 1000 bwfla
RUN addgroup fuse
RUN useradd -ms /bin/bash --uid 1000 --gid bwfla bwfla && for grp in fuse disk audio plugdev kvm; do adduser bwfla $grp; done

run chown bwfla:bwfla /home/bwfla

USER bwfla
#setup basic environment
RUN mkdir -p /home/bwfla/.bwFLA  \
/home/bwfla/demo-ui              \
/home/bwfla/image-archive        \
/home/bwfla/log                  \
/home/bwfla/objects              \
/home/bwfla/server-data		 \
/home/bwfla/import 		 \
/home/bwfla/export		 \
/home/bwfla/defaults

USER root

run mkdir -p /eaas 	\
/eaas/pronom		\
/eaas/roms			

RUN \
  cd /tmp && \
  # git clone https://github.com/Neilpang/acme.sh && \
  # HACK: Needed until <https://github.com/Neilpang/acme.sh/pull/1395> is merged. \
  git clone https://github.com/rafaelgieschke/acme.sh && \
  cd acme.sh && \
  ./acme.sh --install --home /usr/local/acme.sh --config-home /eaas/server-data/acme.sh && \
  chmod +rx /usr/local/acme.sh/ && \
  chown -R bwfla:bwfla /eaas/server-data/acme.sh

COPY --from=eaas/picotcp /libexec/vdenode /libexec/vdenode
COPY --from=eaas/disktype /disktype_json/src/disktype /usr/local/bin
COPY --from=eaas/emucon-tools /emucon-output /usr/local
COPY --from=eaas/criu /usr/local/bin/criu /usr/local/bin
COPY --from=eaas/emucon-tools /emucon-tools /home/bwfla/emucon-tools
COPY --from=eaas/netfilter /out /usr

ENV PATH="/home/bwfla/emucon-tools/runtime/bin/:${PATH}"
RUN /home/bwfla/emucon-tools/install.sh --destination /usr/local -u bwfla \
    &&  /home/bwfla/emucon-tools/installer/install-deps.sh

ADD https://www.nationalarchives.gov.uk/documents/DROID_SignatureFile_V93.xml /eaas/pronom/DROID_SignatureFile.xml
RUN chmod 755 /eaas/pronom/DROID_SignatureFile.xml

add files/defaults /home/bwfla/defaults

run chmod -R 777 /boot

COPY --from=eaas/vde /out /tmp
RUN dpkg -i /tmp/*.deb

run curl ftp://ftp.netfilter.org/pub/iptables/iptables-1.8.2.tar.bz2 -o /tmp/iptables-1.8.2.tar.bz2
workdir /tmp
run tar xf iptables-1.8.2.tar.bz2
workdir iptables-1.8.2
run ./configure     --prefix=/out     --mandir=/usr/man  --disable-nftables
run make
run make install

#add https://gitlab.com/emulation-as-a-service/experiments/fake-clock/-/jobs/164758264/artifacts/raw/LD_PRELOAD_clock_gettime.so /usr/local/lib/

RUN git clone https://gitlab.com/emulation-as-a-service/experiments/fake-clock.git /fake-clock
workdir /fake-clock
run make
run cp LD_PRELOAD_clock_gettime.so /usr/local/lib/
workdir /


