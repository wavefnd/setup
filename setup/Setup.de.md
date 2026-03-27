# Installationsanleitung für die Entwicklungsumgebung

Dieses Dokument beschreibt, wie die Entwicklungsumgebungen für Wave, AOSP, Whale und AriaJDK unter ***Ubuntu 22.04.5 LTS*** oder höher eingerichtet werden.

---

## 1. Wave-Entwicklungsumgebung

Basierend auf dem aktuellen Wave-Quellcode (`llvm/Cargo.toml`) werden jetzt LLVM 21 und Rust 1.86.0 benötigt.

### 1-1. Installation von LLVM 21 (erforderlich)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. LLVM-Umgebungsvariablen konfigurieren

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Installation von Rust 1.86.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Installation von Python (für `x.py`)

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Installation von Git

```bash
sudo apt install -y git
```

### 1-6. Installation der IDEs (optional)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. Build prüfen

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. AOSP-Entwicklungsumgebung

### 2-1. Installation der benötigten Pakete

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Installation von repo

```bash
sudo apt install -y repo
```

AOSP wird gemäß der offiziellen Android-Dokumentation eingerichtet; zusätzliche Abhängigkeiten sind nicht erforderlich.

---

## 3. Whale-Entwicklungsumgebung

Für Whale reicht die Installation von Rust aus.

### 3-1. Installation von Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Installation von Git

```bash
sudo apt install git
```

---

## 4. AriaJDK-Entwicklungsumgebung

AriaJDK verwendet Rust und Kotlin.

### 4-1. Installation von Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Installation der Kotlin-Umgebung

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Installation von Git

```bash
sudo apt install git
```

---

## 5. Verwendung des Installationsskripts

```bash
chmod +x install.sh
./install.sh
```
