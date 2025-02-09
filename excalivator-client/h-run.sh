#!/bin/bash

# Function to update the PATH for the current shell
update_path() {
    export PATH="$HOME/.cargo/bin:$PATH"
    if ! grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.bashrc; then
        echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    fi
    source ~/.bashrc
}

# Check if cargo is installed and accessible
if command -v cargo &> /dev/null; then
    echo "Cargo is already installed and configured."
else
    echo "Cargo is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs/ | sh -s -- -y
    # Update the environment for the current session
    update_path
    source "$HOME/.cargo/env"
    echo "Rust installation complete."
fi

# Check if excalivator-client is installed
if cargo install --list | grep -q "excalivator-client"; then
    echo "Excalivator-client is already installed."
else
    echo "Excalivator-client is not installed. Installing..."
    cargo install excalivator-client
    echo "Excalivator-client installation complete."
fi

# Load h-manifest configuration
if [[ ! -f h-manifest.conf ]]; then
    echo "h-manifest.conf not found. Exiting..."
    exit 1
fi

. h-manifest.conf

if [[ ! -f $CUSTOM_CONFIG_FILENAME ]]; then
    echo "Configuration file $CUSTOM_CONFIG_FILENAME not found. Exiting..."
    exit 1
fi

. "$CUSTOM_CONFIG_FILENAME"

# Run excalivator-client with dynamic path
excalivator_client_path="$(command -v excalivator-client)"
if [[ -z $excalivator_client_path ]]; then
    echo "excalivator-client binary not found. Ensure it's installed correctly. Exiting..."
    exit 1
fi

"$excalivator_client_path" mine-public-key --pubkey "$TEMPLATE"
