#!/bin/bash

go_dir="$HOME/go"

if [ -d "$go_dir" ]; then
    echo "Go is already installed in $go_dir"
    go_version=$(go version 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "Installed Go version: $go_version"
    else
        echo "Unable to determine the installed Go version"
    fi
else
    echo "Go is not installed in $go_dir"
fi
