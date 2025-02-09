#!/usr/bin/env bash

# Check if cargo is installed
if command -v cargo &> /dev/null; then
    echo "Cargo is already installed."
else
    echo "Cargo is not installed. Installing..."
    sudo apt-get update && \
    sudo apt install -y curl git build-essential libssl-dev pkg-config
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs/ | sh -s -- -y
    # Reload shell to ensure cargo is in PATH
    source "$HOME/.cargo/env"
fi

# Check if excalivator-client is installed
if cargo install --list | grep -q "excalivator-client"; then
    echo "Excalivator-client is already installed."
else
    echo "Excalivator-client is not installed. Installing..."
    cargo install excalivator-client
fi

. h-manifest.conf
if [[ ! -f $CUSTOM_CONFIG_FILENAME ]]; then
    echo "Configuration file $CUSTOM_CONFIG_FILENAME not found. Exiting..."
    exit 1
fi
. $CUSTOM_CONFIG_FILENAME

/root/.cargo/bin/excalivator-client mine-public-key --pubkey $TEMPLATE