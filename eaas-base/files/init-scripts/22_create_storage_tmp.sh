#!/bin/bash

if [ ! -d /tmp-storage ]; then 
	mkdir /tmp-storage
	chmod 1777 /tmp-storage
fi

echo "Signature: 8a477f597d28d172789f06886806bc55" > /tmp-storage/CACHEDIR.TAG
