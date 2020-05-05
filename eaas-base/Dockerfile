# create eaas-base
# using: https://github.com/phusion/baseimage-docker

FROM phusion/baseimage:0.11
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confdef" && apt-get clean && apt-get autoremove

#siegfried
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 379CE192D401AB61
run echo "deb http://dl.bintray.com/siegfried/debian wheezy main" | tee -a /etc/apt/sources.list

RUN add-apt-repository ppa:projectatomic/ppa

# gcloud sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

RUN rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
apt-transport-https \
ca-certificates \
dnsutils \
bindfs \
libcurl4 \
libaio1 \
libossp-uuid16 \
libewf2 \
librbd1 \
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
apache2 \
libfaketime \
vde2 \
nghttp2-proxy \
sudo \
jq \
git \
rsync \
openjdk-8-jre-headless \
socat \
mongodb \
siegfried \
skopeo \
wget \
squashfs-tools \
cpu-checker \
libprotobuf-c1 \
iproute2 \
ghostscript \
gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad \
gstreamer1.0-nice \
gstreamer1.0-libav \
gstreamer1.0-tools \
gstreamer1.0-pulseaudio \
    && apt-get clean && apt-get autoremove

RUN sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf

RUN rm -rf /usr/lib/xmount/libxmount_input_aff.so

## prepare the system to host sheepshaver
copy files/sheepshaver.sysctl /etc/sysctl.d/30-sheepshaver.conf

COPY files/init-scripts/ /etc/my_init.d/

# allow loop devices to be mounted by users
#COPY files/pmount.allow /etc/pmount.allow

## prepare services
COPY files/service /etc/service/

## prepare services
COPY files/sudoers/citar-passwordless-commands /etc/sudoers.d/citar-passwordless-commands
RUN chmod 440 /etc/sudoers.d/citar-passwordless-commands

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
RUN useradd -ms /bin/bash --uid 1000 --gid bwfla bwfla && for grp in fuse disk audio plugdev; do adduser bwfla $grp; done

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
  git clone https://gitlab.com/emulation-as-a-service/acme.sh && \
  cd acme.sh && \
  ./acme.sh --install --home /usr/local/acme.sh --config-home /eaas/server-data/acme.sh && \
  chmod +rx /usr/local/acme.sh/ && \
  chown -R bwfla:bwfla /eaas/server-data/acme.sh

COPY --from=eaas/custom-packages /debs/*.deb /tmp/packages/
COPY --from=eaas/custom-packages /qemu/debian/tmp /tmp/packages/build/
RUN cd /tmp/packages && dpkg -i \
  libguac7_*.deb \
  libguac-client-sdlonp0_*.deb \
  guacd_*.deb \
  xmount_*.deb \
  libxmount-input-qemu_*.deb \
  && apt-get clean \
  && cp -r -v ./build/usr/* /usr \
  && rm -r /tmp/packages

run curl -o /libexec/eaas-proxy-download.zip -L https://gitlab.com/emulation-as-a-service/eaas-proxy/-/jobs/248331762/artifacts/download \
  && cd /libexec \
  && unzip eaas-proxy-download.zip \
  && mv eaas-proxy/eaas-proxy vdenode \
  && rm -r eaas-proxy \
  && rm eaas-proxy-download.zip

COPY --from=eaas/disktype /disktype_json/src/disktype /usr/local/bin
COPY --from=eaas/emucon-tools /emucon-output /usr/local
COPY --from=eaas/criu /usr/local/bin/criu /usr/local/bin
COPY --from=eaas/emucon-tools /emucon-tools /home/bwfla/emucon-tools
COPY --from=eaas/netfilter /usr/local /usr/local
COPY --from=eaas/fake-clock /fake-clock/LD_PRELOAD_clock_gettime.so /usr/local/lib/
COPY --from=eaas/test-sock-diag /src/test-sock-diag /usr/local/bin/

ENV PATH="/home/bwfla/emucon-tools/runtime/bin/:${PATH}"
RUN /home/bwfla/emucon-tools/install.sh --destination /usr/local -u bwfla \
    &&  /home/bwfla/emucon-tools/installer/install-deps.sh

ADD https://www.nationalarchives.gov.uk/documents/DROID_SignatureFile_V93.xml /eaas/pronom/DROID_SignatureFile.xml
RUN chmod 755 /eaas/pronom/DROID_SignatureFile.xml

add files/defaults /home/bwfla/defaults

run chmod -R 777 /boot

# update linker cache
RUN ldconfig

COPY --from=eaas/vde /out /tmp
RUN dpkg -i /tmp/*.deb && rm /tmp/*.deb

run curl -o /usr/local/lib/LD_PRELOAD_libcurl.so -L https://gitlab.com/emulation-as-a-service/experiments/fake-libcurl/-/jobs/artifacts/prefix-proxy/raw/LD_PRELOAD_libcurl.so?job=build
run chmod 755 /usr/local/lib/LD_PRELOAD_libcurl.so

run curl -L -o /tmp/vde-slirp.zip https://gitlab.com/emulation-as-a-service/slirp-helper/-/jobs/artifacts/master/download/?job=build && \
	mkdir -p /libexec/vde && \ 
	cd /libexec/vde && \
	unzip /tmp/vde-slirp.zip  
