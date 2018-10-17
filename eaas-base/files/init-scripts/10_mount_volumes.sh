#!/bin/bash


bindmount() {
    if [ $# -ne 2 ]; then
        echo Fatal: wrong number of arguments to bindmount
        exit 1
    fi

    bindfs -u bwfla --create-for-user=$(stat -c "%u" "$1") --create-for-group=$(stat -c "%g" "$1") "$1" "$2"
}

test -d /eaas/emil-environments && bindmount /eaas/emil-environments /home/bwfla/emil-environments
test -d /eaas/emil-object-environments && bindmount /eaas/emil-object-environments /home/bwfla/emil-object-environments

if [ -d /eaas/log ]; then 
	echo mount log
	bindmount /eaas/log /home/bwfla/log
fi

if [ -d /eaas/config ]; then
	echo mount config
	bindmount /eaas/config /home/bwfla/.bwFLA
fi

if [ -d /eaas/server-data ]; then
	echo mount server-data
	bindmount /eaas/server-data /home/bwfla/server-data
fi

if [ -d /eaas/image-archive ]; then	
	echo mounting imagearchive
	bindmount /eaas/image-archive /home/bwfla/image-archive
fi

if [ -d /eaas/objects ]; then
	echo mount objects
	bindmount /eaas/objects /home/bwfla/objects
fi

if [ -d /eaas/export ]; then
	echo mount export
	bindmount /eaas/export /home/bwfla/export
fi

if [ -d /eaas/import ]; then
	echo mount import
	bindmount /eaas/import /home/bwfla/import
fi


if [ -d /eaas/demo-ui ]; then
	echo mounting demo-ui
	bindmount /eaas/demo-ui /home/bwfla/demo-ui
fi

