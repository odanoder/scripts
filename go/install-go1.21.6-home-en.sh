#!/bin/bash

# Ask user for the Go version
read -p "Enter the Go version to install (default is 1.21.6): " input_version

# Use 1.21.6 if nothing is entered
version=${input_version:-1.21.6}

# Prepare directory
mkdir -p $HOME/go
cd $HOME

# Download and install the selected Go version
wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
tar -C $HOME/ -xzf "go$version.linux-amd64.tar.gz"
rm "go$version.linux-amd64.tar.gz"

# Add the path to binaries in .bashrc
echo "export PATH=\$PATH:$HOME/go/bin" >> $HOME/.bashrc

# Update the current session
source $HOME/.bashrc

# Display the Go version after installation
go version

# Completion message
echo "Go $version installation completed."
