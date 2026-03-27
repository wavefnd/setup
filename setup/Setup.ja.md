# 開発環境インストールガイド

本ドキュメントは、Wave、AOSP、Whale、AriaJDK の開発環境を ***Ubuntu 22.04.5 LTS*** 以上で構築するためのインストール手順です。

---

## 1. Wave 開発環境

現在の Wave ソース（`llvm/Cargo.toml`）基準では、LLVM 21 と Rust 1.86.0 が必要です。

### 1-1. LLVM 21 のインストール（必須）

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. LLVM 環境変数の設定

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Rust 1.86.0 のインストール

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Python のインストール（`x.py` 用）

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Git のインストール

```bash
sudo apt install -y git
```

### 1-6. IDE のインストール（任意）

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. ビルド確認

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. AOSP 開発環境

### 2-1. 必要パッケージのインストール

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. repo のインストール

```bash
sudo apt install -y repo
```

AOSP は公式 Android ドキュメントに従って進めればよく、追加の依存パッケージは不要です。

---

## 3. Whale 開発環境

Whale の構築には Rust のインストールのみで十分です。

### 3-1. Rust のインストール

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Git のインストール

```bash
sudo apt install git
```

---

## 4. AriaJDK 開発環境

AriaJDK は Rust と Kotlin を使用します。

### 4-1. Rust のインストール

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Kotlin 環境のインストール

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Git のインストール

```bash
sudo apt install git
```

---

## 5. インストールスクリプトの使い方

```bash
chmod +x install.sh
./install.sh
```
