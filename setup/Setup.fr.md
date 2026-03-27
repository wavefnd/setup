# Guide d’installation de l’environnement de développement

Ce document fournit les instructions pour configurer les environnements de développement de Wave, AOSP, Whale et AriaJDK sur ***Ubuntu 22.04.5 LTS*** ou une version ultérieure.

---

## 1. Environnement de développement Wave

D'après le code source actuel de Wave (`llvm/Cargo.toml`), Wave nécessite désormais LLVM 21 et Rust 1.86.0.

### 1-1. Installation de LLVM 21 (obligatoire)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. Configuration des variables d'environnement LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Installation de Rust 1.86.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Installation de Python (pour `x.py`)

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Installation de Git

```bash
sudo apt install -y git
```

### 1-6. Installation des IDE (optionnelle)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. Vérifier la compilation

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. Environnement de développement AOSP

### 2-1. Installation des paquets requis

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Installation de repo

```bash
sudo apt install -y repo
```

AOSP se configure selon la documentation officielle d’Android ; aucune dépendance supplémentaire n’est nécessaire.

---

## 3. Environnement de développement Whale

Whale ne nécessite que Rust pour son installation.

### 3-1. Installation de Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Installation de Git

```bash
sudo apt install git
```

---

## 4. Environnement de développement AriaJDK

AriaJDK utilise Rust et Kotlin.

### 4-1. Installation de Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Installation de l’environnement Kotlin

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Installation de Git

```bash
sudo apt install git
```

---

## 5. Utilisation du script d’installation

```bash
chmod +x install.sh
./install.sh
```
