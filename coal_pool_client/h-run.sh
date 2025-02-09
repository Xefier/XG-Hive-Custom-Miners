#!/usr/bin/env bash

. h-manifest.conf
. $CUSTOM_CONFIG_FILENAME

#coal-pool-client
/root/.cargo/bin/coal-pool-client --pubkey $TEMPLATE