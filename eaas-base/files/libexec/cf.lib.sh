#!/bin/sh
# set -xeu

# See: https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys
# cf_token="$(cat TOKEN)"
cf_token="$CF_Token"

# See: https://support.cloudflare.com/hc/en-us/articles/205075117-Understanding-the-Cloudflare-dashboard
# cf_zone_id="$(cat ZONE_ID)"
cf_zone_id="$CF_Zone_ID"

# See: https://api.cloudflare.com/#dns-records-for-a-zone-create-dns-record
cf_base="https://api.cloudflare.com/client/v4/zones/$cf_zone_id/dns_records"

cf_curl() {
    curl -H "Authorization: Bearer $cf_token" -H "Content-Type: application/json" "$@"
}

cf_find_id() {
    if test "${2:-}"; then
       cf_curl -X GET "$cf_base?name=$1&type=$2" | jq -r '.result[0].id // ""'
    else
       cf_curl -X GET "$cf_base?name=$1" | jq -r '.result[0].id // ""'
    fi
}

cf_format_record() {
    # HACK: jq >= 1.6 (Ubuntu 18.04 has jq 1.5) would use `jq -n '$ARGS.named'`
    jq -n '{$name,$type,$content,$ttl,$proxied}' --arg name "$1" --arg type "$2" \
        --arg content "$3" --argjson ttl "$4" --argjson proxied false
}

cf_create_or_update_record() (
    name="$1"
    type="$2"
    content="$3"
    # Cloudflare does not allow ttl < 120; 1 is "automatic".
    ttl="${4:-1}"

    record="$(cf_format_record "$name" "$type" "$content" "$ttl")"

    old_id="$(cf_find_id "$name" "$type")"
    if test "$old_id"; then
        cf_curl -X PUT "$cf_base/$old_id" --data "$record"
    else
        cf_curl -X POST "$cf_base" --data "$record"
    fi
)

cf_delete_record() (
    name="$1"
    type="${2:-}"

    old_id="$(cf_find_id "$name" "$type")"
    if test "old_id"; then
        cf_curl -X DELETE "$cf_base/$old_id"
    fi
)
