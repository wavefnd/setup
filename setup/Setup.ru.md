# Руководство по установке среды разработки

Этот документ содержит инструкции по настройке сред разработки Wave, AOSP, Whale и AriaJDK на ***Ubuntu 22.04.5 LTS*** или более новой версии.

---

## 1. Среда разработки Wave

Согласно текущему исходному коду Wave (`llvm/Cargo.toml`), теперь требуются LLVM 21 и Rust 1.86.0.

### 1-1. Установка LLVM 21 (обязательно)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. Настройка переменных окружения LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Установка Rust 1.86.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Установка Python (для `x.py`)

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Установка Git

```bash
sudo apt install -y git
```

### 1-6. Установка IDE (опционально)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. Проверка сборки

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. Среда разработки AOSP

### 2-1. Установка необходимых пакетов

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Установка repo

```bash
sudo apt install -y repo
```

AOSP настраивается согласно официальной документации Android; дополнительные зависимости не требуются.

---

## 3. Среда разработки Whale

Для Whale достаточно установить Rust.

### 3-1. Установка Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Установка Git

```bash
sudo apt install git
```

---

## 4. Среда разработки AriaJDK

AriaJDK использует Rust и Kotlin.

### 4-1. Установка Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Установка среды Kotlin

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Установка Git

```bash
sudo apt install git
```

---

## 5. Использование установочного скрипта

```bash
chmod +x install.sh
./install.sh
```
