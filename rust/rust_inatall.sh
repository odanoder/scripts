#!/bin/bash
sudo apt update -y
sudo apt install curl make clang pkg-config libssl-dev build-essential git mc jq unzip wget -y
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
sleep 5


# Когда Rust устанавливается через скрипт sh -s -- -y, параметр -y автоматически принимает все стандартные настройки без необходимости ручного выбора.
# По умолчанию Rust установится с default toolchain (stable) и добавит cargo, rustc, rustup в ~/.cargo/bin.
# После выполнения source $HOME/.cargo/env они будут доступны в текущей сессии.
# rustup show   Показать текущую версию
# rustup update   Обновить Rust до актуальной версии
# rustup default stable  Назначить стабильную версию по умолчанию
# rustup default nightly Переключиться на nightly-версию
