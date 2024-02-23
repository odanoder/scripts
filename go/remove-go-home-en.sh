#!/bin/bash

# Check if Go is installed
if command -v go &>/dev/null; then
    # Remove the Go directory
    sudo rm -rf "$HOME/go"

    # Remove the corresponding line from .bashrc
    sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

    echo "Go has been successfully removed from the home directory'${HOME}'."
else
    echo "Go was not found in the home directory '${HOME}'."
fi
