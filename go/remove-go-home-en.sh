#!/bin/bash

# Check if the Go directory exists
if [ -d "$HOME/go" ]; then
    # Remove the Go directory with superuser privileges
    sudo rm -rf "$HOME/go"
    
    # Remove the corresponding line from .bashrc
    sudo sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

    echo "Go has been successfully removed from the home directory '${HOME}'."
else
    echo "The Go directory was not found in the home directory '${HOME}'."
fi
