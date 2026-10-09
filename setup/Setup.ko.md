# 개발 환경 설치 가이드

이 문서는 Wave, AOSP, Whale, AriaJDK 개발 환경을 ***Ubuntu 22.04.5 LTS*** 이상에서 구성하기 위한 설치 안내입니다.

아래 명령은 **x86-64 Ubuntu와 Bash**를 기준으로 합니다. Wave만 빌드하려면 1절을 따르면 됩니다. AOSP, Whale, AriaJDK 절은 별도의 프로젝트를 위한 안내입니다. Linux, macOS, Windows용 사전 빌드 릴리스는 [Wave 설치 가이드](https://wave-lang.dev/docs/getting-started/install)를 참고하세요.

---

## 1. Wave 개발 환경

Wave는 LLVM 21을 사용합니다([`llvm/Cargo.toml`](https://github.com/wavefnd/Wave/blob/master/llvm/Cargo.toml)). 이 가이드는 [Wave CI](https://github.com/wavefnd/Wave/blob/master/tools/ci/toolchains.json)에 맞춰 Rust 1.89.0을 사용합니다.

### 1-1. LLVM 21 설치 (필수)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
sudo apt install -y llvm-21-dev clang-21 lld-21
```

### 1-2. LLVM 환경 변수 설정

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Rust 1.89.0 설치

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.89.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.89.0
```

### 1-4. Python 설치 (선택 사항, `x.py`용)

아래 Cargo 빌드에는 Python이 필요하지 않습니다. 선택 사항인 `x.py` 도구에는 **Python 3.11 이상**이 필요하며, Ubuntu 22.04의 기본 Python 3.10으로는 실행할 수 없습니다. `x.py`를 사용하기 전에 버전을 확인하세요. `toml` 패키지를 설치해도 Python의 `tomllib` 모듈을 대체하지 못합니다.

```bash
sudo apt install -y python3
python3 --version
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

소스를 보관할 디렉터리에서 실행하세요. 이미 Wave를 복제했다면 `git clone`을 건너뛰고 해당 디렉터리로 이동하세요. Rust 오버라이드는 이 체크아웃에만 적용됩니다.

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

`cargo build --locked`는 저장소에 기록된 의존성 버전을 사용합니다. 개발용 컴파일러는 `target/debug/wavec`에 생성됩니다. 버전 확인 명령은 이 실행 파일을 직접 사용하므로 전역 설치가 필요하지 않습니다.

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

이 선택 사항인 스크립트는 **setup 저장소의 루트**에서 실행하세요. 네 프로젝트의 도구를 모두 설치하고 기본 Rust 툴체인을 변경합니다. 현재 Wave 소스의 요구 사항은 위 1절의 수동 절차를 따르세요.

```bash
chmod +x install.sh
./install.sh
```
