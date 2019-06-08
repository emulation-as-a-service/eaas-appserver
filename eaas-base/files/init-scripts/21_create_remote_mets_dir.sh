#!/bin/bash

if [ ! -d /eaas/server-data/metsRemoteMetadata ]; then 
	mkdir /eaas/server-data/metsRemoteMetadata
	chmod 777 /eaas/server-data/metsRemoteMetadata
fi
