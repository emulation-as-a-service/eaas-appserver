FROM ubuntu:bionic

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install sudo jq -y
run echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

### build oci-tools
RUN mkdir /emucon-output
ADD emucon-tools/builder/commands/tool/scripts /tmp/emucon-oci-scripts
ADD emucon-tools /emucon-tools
RUN /tmp/emucon-oci-scripts/build.sh runc runtime-tools image-tools

