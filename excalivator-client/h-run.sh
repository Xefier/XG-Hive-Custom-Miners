#!/usr/bin/env bash

# Install GLIBC_2.39 if necessary
ldd --version | grep -q "2.39" && echo "GLIBC 2.39 is already installed." || (sudo apt update && sudo apt install -y build-essential manpages-dev && cd /usr/src && sudo wget -q http://ftp.gnu.org/gnu/libc/glibc-2.39.tar.gz && sudo tar -xzf glibc-2.39.tar.gz && cd glibc-2.39 && mkdir build && cd build && sudo ../configure --prefix=/opt/glibc-2.39 && sudo make -j$(nproc) && sudo make install && echo "export LD_LIBRARY_PATH=/opt/glibc-2.39/lib:\$LD_LIBRARY_PATH" | sudo tee -a /etc/profile && source /etc/profile && echo "GLIBC 2.39 installed successfully.")

. h-manifest.conf
if [[ ! -f $CUSTOM_CONFIG_FILENAME ]]; then
    echo "Configuration file $CUSTOM_CONFIG_FILENAME not found. Exiting..."
    exit 1
fi
. $CUSTOM_CONFIG_FILENAME

./excalivator-client mine-public-key --pubkey $TEMPLATE