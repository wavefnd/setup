# 开发环境安装指南

本文档用于说明如何在 ***Ubuntu 22.04.5 LTS*** 及以上版本中配置 Wave、AOSP、Whale、AriaJDK 的开发环境。

---

## 1. Wave 开发环境

根据当前 Wave 源码（`llvm/Cargo.toml`），现在需要 LLVM 21 和 Rust 1.86.0。

### 1-1. 安装 LLVM 21（必需）

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. 配置 LLVM 环境变量

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. 安装 Rust 1.86.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. 安装 Python（用于 `x.py`）

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. 安装 Git

```bash
sudo apt install -y git
```

### 1-6. 安装 IDE（可选）

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. 验证构建

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. AOSP 开发环境

### 2-1. 安装必要软件包

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. 安装 repo

```bash
sudo apt install -y repo
```

AOSP 的配置遵循官方 Android 文档，无需额外依赖。

---

## 3. Whale 开发环境

Whale 仅需安装 Rust 即可。

### 3-1. 安装 Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. 安装 Git

```bash
sudo apt install git
```

---

## 4. AriaJDK 开发环境

AriaJDK 使用 Rust 和 Kotlin。

### 4-1. 安装 Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. 安装 Kotlin 环境

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. 安装 Git

```bash
sudo apt install git
```

---

## 5. 使用安装脚本

```bash
chmod +x install.sh
./install.sh
```
