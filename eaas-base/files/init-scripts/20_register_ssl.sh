#!/bin/bash

if test -f "/home/bwfla/.bwFLA/dns-env"; then
	/libexec/init-host-ssl
fi
