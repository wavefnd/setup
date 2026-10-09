# Guía de Instalación del Entorno de Desarrollo

Este documento proporciona las instrucciones para configurar los entornos de desarrollo de Wave, AOSP, Whale y AriaJDK en ***Ubuntu 22.04.5 LTS*** o superior.

Los comandos siguientes suponen **Ubuntu x86-64 y Bash**. Para compilar solo Wave, siga la sección 1; las secciones de AOSP, Whale y AriaJDK son independientes. Para versiones precompiladas en Linux, macOS o Windows, consulte la [guía de instalación de Wave](https://wave-lang.dev/docs/getting-started/install).

---

## 1. Entorno de Desarrollo de Wave

Wave utiliza LLVM 21 ([`llvm/Cargo.toml`](https://github.com/wavefnd/Wave/blob/master/llvm/Cargo.toml)). Esta guía utiliza Rust 1.89.0, igual que la [CI de Wave](https://github.com/wavefnd/Wave/blob/master/tools/ci/toolchains.json).

### 1-1. Instalación de LLVM 21 (obligatorio)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
sudo apt install -y llvm-21-dev clang-21 lld-21
```

### 1-2. Configurar variables de entorno de LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Instalación de Rust 1.89.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.89.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.89.0
```

### 1-4. Instalación de Python (opcional, para `x.py`)

La compilación con Cargo que se muestra abajo no necesita Python. La herramienta opcional `x.py` requiere **Python 3.11 o posterior**; Python 3.10, incluido por defecto en Ubuntu 22.04, no es suficiente. Compruebe la versión antes de usar `x.py`; instalar el paquete `toml` no sustituye al módulo `tomllib` de Python.

```bash
sudo apt install -y python3
python3 --version
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

Ejecute estos comandos desde el directorio donde quiera guardar el código fuente. Si ya tiene una copia de Wave, omita `git clone` y cambie a ese directorio. La selección de Rust con `override` solo se aplica a esta copia.

```bash
git clone https://github.com/wavefnd/Wave.git
cd Wave
rustup override set 1.89.0
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
"$LLVM_CONFIG_PATH" --version
rustc --version
cargo build --locked
./target/debug/wavec --version
```

`cargo build --locked` utiliza las versiones de las dependencias fijadas en el repositorio. El compilador de desarrollo se genera en `target/debug/wavec`; el comando de versión comprueba ese ejecutable directamente, sin una instalación global.

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

Ejecute este script opcional desde la raíz del **repositorio setup**. Instala herramientas para los cuatro proyectos y cambia la cadena de herramientas de Rust predeterminada. Para los requisitos del código fuente actual de Wave, siga los pasos manuales de la sección 1.

```bash
chmod +x install.sh
./install.sh
```
