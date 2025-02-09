#!/usr/bin/env bash

. h-manifest.conf
if [[ ! -f $CUSTOM_CONFIG_FILENAME ]]; then
    echo "Configuration file $CUSTOM_CONFIG_FILENAME not found. Exiting..."
    exit 1
fi
. $CUSTOM_CONFIG_FILENAME

./excalivator-client mine-public-key --pubkey $TEMPLATE