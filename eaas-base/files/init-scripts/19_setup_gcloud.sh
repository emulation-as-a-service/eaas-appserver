#!/bin/sh

set -eu

srcpath='/home/bwfla/.bwFLA/dns-env'
test -f "${srcpath}" || exit 0

. "${srcpath}"

test "${EAAS_DNS_PROVIDER}" = 'gcp' || exit 0

DEBIAN_FRONTEND=noninteractive apt-get install -y google-cloud-sdk

__activate_service_account() {
	local user="$1"
	echo "Activating service-account for ${user} user..."
	sudo -u "${user}" gcloud auth activate-service-account \
		"${EAAS_DNS_SERVICE_ACCOUNT_EMAIL}" \
		--key-file "${EAAS_DNS_SERVICE_ACCOUNT_FILE}" \
		--project "${EAAS_DNS_PROJECT_ID}"
}

__activate_service_account root
__activate_service_account bwfla
