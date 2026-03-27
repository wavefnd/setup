# 개발 환경 설치 가이드

이 문서는 Wave, AOSP, Whale, AriaJDK 개발 환경을 ***Ubuntu 22.04.5 LTS*** 이상에서 구성하기 위한 설치 안내입니다.

---

## 1. Wave 개발 환경

Wave 소스 기준(`llvm/Cargo.toml`)으로 LLVM 21 + Rust 1.86.0 환경이 필요합니다.

### 1-1. LLVM 21 설치 (필수)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
```

### 1-2. LLVM 환경 변수 설정

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Rust 1.86.0 설치

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 1-4. Python 설치 (`x.py`용)

```bash
sudo apt install -y python3 python3-pip python3-venv python3-tk
pip install toml
```

### 1-5. Git 설치

```bash
sudo apt install -y git
```

### 1-6. IDE 설치 (선택)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. 빌드 확인

```bash
cd /mnt/hdd/Wave
export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21
export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config
llvm-config --version
rustc --version
cargo build
```

---

## 2. AOSP 개발 환경

### 2-1. 필수 패키지 설치

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Repo 설치

```bash
sudo apt install -y repo
```

AOSP는 공식 Android 문서에 따라 진행하면 되고, 추가 의존성은 필요하지 않음.

---

## 3. Whale 개발 환경

Whale은 Rust만 설치하면 충분합니다.

### 3-1. Rust 설치

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Git 설치

```bash
sudo apt install git
```

---

## 4. AriaJDK 개발 환경

AriaJDK는 Rust + Kotlin을 사용합니다.

### 4-1. Rust 설치

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Kotlin 환경 설치

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Git 설치

```bash
sudo apt install git
```

---

## 5. 설치 스크립트 사용법

```bash
chmod +x install.sh
./install.sh
```
