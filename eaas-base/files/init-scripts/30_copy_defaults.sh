#!/bin/bash

if [ ! -e /home/bwfla/server-data/operating-systems.json ]; then
   cp -v /home/bwfla/defaults/operating-systems.json /home/bwfla/server-data
fi

if [ -e /home/bwfla/defaults/templates ]; then
   mkdir -p /home/bwfla/image-archive/meta-data/template
   cp -vr /home/bwfla/defaults/templates/* /home/bwfla/image-archive/meta-data/template
fi

if [ -e /home/bwfla/defaults/remote ]; then
   mkdir -p /home/bwfla/image-archive/remote/meta-data/base/
   cp -rv /home/bwfla/defaults/remote/linux/* /home/bwfla/image-archive/remote/meta-data/base/
fi
