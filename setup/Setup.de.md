# Installationsanleitung für die Entwicklungsumgebung

Dieses Dokument beschreibt, wie die Entwicklungsumgebungen für Wave, AOSP, Whale und AriaJDK unter ***Ubuntu 22.04.5 LTS*** oder höher eingerichtet werden.

---

## 1. Wave-Entwicklungsumgebung

### 1-1. Installation von LLVM

```bash
sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
```

### 1-2. Installation von Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 1-3. Installation von Git

```bash
sudo apt install git
```

### 1-4. Installation von Python

```bash
sudo apt install python3 python3-pip python3-venv
pip install toml
```

### 1-5. Installation der IDEs

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-6. Installation von Entwicklungswerkzeugen

```bash
sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build \
lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano
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
rustup default 1.86
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
rustup default 1.86
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