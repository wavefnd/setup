# 開発環境インストールガイド

本ドキュメントは、Wave、AOSP、Whale、AriaJDK の開発環境を ***Ubuntu 22.04.5 LTS*** 以上で構築するためのインストール手順です。

---

## 1. Wave 開発環境

### 1-1. LLVM のインストール

```bash
sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
```

### 1-2. Rust のインストール

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 1-3. Git のインストール

```bash
sudo apt install git
```

### 1-4. Python のインストール

```bash
sudo apt install python3 python3-pip python3-venv
pip install toml
```

### 1-5. IDE のインストール

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-6. 開発ツールのインストール

```bash
sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build \
lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano
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
rustup default 1.86
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
rustup default 1.86
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