#!/usr/bin/env bash

cargo install excalivator-client

. h-manifest.conf
if [[ ! -f $CUSTOM_CONFIG_FILENAME ]]; then
    echo "Configuration file $CUSTOM_CONFIG_FILENAME not found. Exiting..."
    exit 1
fi
. $CUSTOM_CONFIG_FILENAME

/root/.cargo/bin/excalivator-client mine-public-key --pubkey $TEMPLATE