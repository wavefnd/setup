# 개발 환경 설치 가이드

이 문서는 Wave, AOSP, Whale, AriaJDK 개발 환경을 ***Ubuntu 22.04.5 LTS*** 이상에서 구성하기 위한 설치 안내입니다.

---

## 1. Wave 개발 환경

### 1-1. LLVM 설치

```bash
sudo apt install -y llvm-14 llvm-14-dev clang-14 libclang-14-dev lld-14 clang
```

### 1-2. Rust 설치

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86
```

### 1-3. Git 설치

```bash
sudo apt install git
```

### 1-4. Python 설치

```bash
sudo apt install python3 python3-pip python3-venv
pip install toml
```

### 1-5. IDE 설치 

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-6. 개발 도구 설치

```bash
sudo apt install -y build-essential curl wget zip unzip pkg-config cmake ninja-build \
lld clang lldb make libssl-dev libffi-dev qemu-system-x86 ovmf vim nano
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
rustup default 1.86
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
rustup default 1.86
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