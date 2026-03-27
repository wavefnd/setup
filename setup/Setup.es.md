# Guía de Instalación del Entorno de Desarrollo

Este documento proporciona las instrucciones para configurar los entornos de desarrollo de Wave, AOSP, Whale y AriaJDK en ***Ubuntu 22.04.5 LTS*** o superior.

---

## 1. Entorno de Desarrollo de Wave

Según el código fuente actual de Wave (`llvm/Cargo.toml`), ahora se requieren LLVM 21 y Rust 1.86.0.

### 1-1. Instalación de LLVM 21 (obligatorio)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. Configurar variables de entorno de LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Instalación de Rust 1.86.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Instalación de Python (para `x.py`)

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Instalación de Git

```bash
sudo apt install -y git
```

### 1-6. Instalación del IDE (opcional)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. Validar compilación

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. Entorno de Desarrollo de AOSP

### 2-1. Instalación de Paquetes Necesarios

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Instalación de repo

```bash
sudo apt install -y repo
```

AOSP se configura siguiendo la documentación oficial de Android; no se requieren dependencias adicionales.

---

## 3. Entorno de Desarrollo de Whale

Whale only requires Rust.

### 3-1. Instalación de Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Instalación de Git

```bash
sudo apt install git
```

---

## 4. Entorno de Desarrollo de AriaJDK

AriaJDK utiliza Rust y Kotlin.

### 4-1. Instalación de Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Instalación del Entorno de Kotlin

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Instalación de Git

```bash
sudo apt install git
```

---

## 5. Uso del Script de Instalación

```bash
chmod +x install.sh
./install.sh
```
