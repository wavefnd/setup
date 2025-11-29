#!/usr/bin/env bash
set -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
sudo apt install -y rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
sudo apt install -y git

sudo apt install -y python3 python3-pip python3-venv
pip install toml

sudo apt install -y snapd
sudo snap install rustrover --classic
sudo snap install --classic code

sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano

sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
sudo apt install -y repo

rustup target add x86_64-unknown-linux-gnu
rustup default 1.86

sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
