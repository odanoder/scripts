#!/bin/bash

go_dir="$HOME/go"

if [ -d "$go_dir" ]; then
    echo "Go is already installed in $go_dir"
    echo "Go уже установлен в $go_dir"
    go_version=$(go version 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "Installed Go version: $go_version"
        echo "Установленная версия Go: $go_version"
    else
        echo "Unable to determine the installed Go version"
        echo "Невозможно определить установленную версию Go"
    fi
else
    echo "Go is not installed in $go_dir"
    echo "Go не установлен в $go_dir"
fi
