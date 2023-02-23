#!/bin/sh

GOOGLE_DOMAINS=https://www.google.com/supported_domains
curl --silent "$GOOGLE_DOMAINS" | \
    sed "s/^./*/;s/$/ forcesafesearch.google.com/"
