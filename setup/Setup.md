# Development Environment Installation Guide

This document provides instructions to set up the development environment for Wave, AOSP, Whale, and AriaJDK on ***Ubuntu 22.04.5 LTS*** or later.

---

## 1. Wave Development Environment

### 1-1. Install LLVM

```bash
sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
```

### 1-2. Install Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 1-3. Install Git

```bash
sudo apt install git
```

### 1-4. Install Python

```bash
sudo apt install python3 python3-pip python3-venv
pip install toml
```

### 1-5. Install IDEs

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-6. Install Development Tools

```bash
sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build \
lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano
```

---

## 2. AOSP Development Environment

### 2-1. Install Required Packages

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Install Repo

```bash
sudo apt install -y repo
```

AOSP setup follows the official Android documentation. No additional dependencies are required beyond these packages.

---

## 3. Whale Development Environment

Whale only requires Rust.

### 3-1. Install Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 3-2. Install Git

```bash
sudo apt install git
```

---

## 4. AriaJDK Development Environment

AriaJDK uses Rust and Kotlin.

### 4-1. Install Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 4-2. Install Kotlin and JDK

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Install Git

```bash
sudo apt install git
```

---

## 5. Using the Installation Script

```bash
chmod +x install.sh
./install.sh
```