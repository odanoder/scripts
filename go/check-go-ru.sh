#!/bin/bash

go_dir="$HOME/go"

if [ -d "$go_dir" ]; then
    echo "Go уже установлен в $go_dir"
    go_version=$(go version 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "Установленная версия Go: $go_version"
    else
        echo "Невозможно определить установленную версию Go"
    fi
else
    echo "Go не установлен в $go_dir"
fi
