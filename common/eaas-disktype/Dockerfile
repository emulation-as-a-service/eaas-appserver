FROM ubuntu:xenial

run apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install build-essential -y  --allow-unauthenticated

add disktype_json /disktype_json
WORKDIR /disktype_json/src
run make

