from ubuntu:xenial

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
curl git

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
nodejs zip

add picotcp /libexec/picotcp
run rm -rf /libexec/picotcp/.git
workdir /libexec/picotcp/webemulator/webemulator
run npm install
run npm run build
run cp ./eaas-proxy /libexec/vdenode
run mkdir /download/
run cp ./eaas-proxy.exe /download/
run cp ./eaas-proxy.app.zip /download/
