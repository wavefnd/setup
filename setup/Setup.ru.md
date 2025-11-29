# Руководство по установке среды разработки

Этот документ содержит инструкции по настройке сред разработки Wave, AOSP, Whale и AriaJDK на ***Ubuntu 22.04.5 LTS*** или более новой версии.

---

## 1. Среда разработки Wave

### 1-1. Установка LLVM

```bash
sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
```

### 1-2. Установка Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 1-3. Установка Git

```bash
sudo apt install git
```

### 1-4. Установка Python

```bash
sudo apt install python3 python3-pip python3-venv
pip install toml
```

### 1-5. Установка IDE

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-6. Установка инструментов разработки

```bash
sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build \
lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano
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
rustup default 1.86
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
rustup default 1.86
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