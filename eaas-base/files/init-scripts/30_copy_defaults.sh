#!/bin/bash

if [ ! -e /home/bwfla/server-data/operating-systems.json ]; then
   cp -v /home/bwfla/defaults/operating-systems.json /home/bwfla/server-data
fi
