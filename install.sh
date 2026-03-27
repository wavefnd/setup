#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt upgrade -y

# 1) Wave
sudo apt install -y wget software-properties-common lsb-release gnupg
wget -q https://apt.llvm.org/llvm.sh -O /tmp/llvm.sh
chmod +x /tmp/llvm.sh
sudo /tmp/llvm.sh 21
rm -f /tmp/llvm.sh

if ! grep -qxF 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' "$HOME/.bashrc"; then
  echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> "$HOME/.bashrc"
fi

if ! grep -qxF 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' "$HOME/.bashrc"; then
  echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> "$HOME/.bashrc"
fi

export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config

sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates

if ! command -v rustup >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
fi

if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

rustup toolchain install 1.86.0
rustup default 1.86.0
rustup target add x86_64-unknown-linux-gnu

sudo apt install -y git

sudo apt install -y python3 python3-pip python3-venv python3-tk
python3 -m pip install --user toml || python3 -m pip install --break-system-packages toml

sudo apt install -y snapd
snap list rustrover >/dev/null 2>&1 || sudo snap install rustrover --classic
snap list code >/dev/null 2>&1 || sudo snap install --classic code

sudo apt install -y zip unzip cmake ninja-build lld clang lldb make libffi-dev qemu-system-x86 ovmf vim nano

# 2) AOSP
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
  libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
  libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
sudo apt install -y repo

# 3) Whale
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0

# 4) AriaJDK
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
snap list kotlin >/dev/null 2>&1 || sudo snap install kotlin --classic
