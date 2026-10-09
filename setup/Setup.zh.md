# 开发环境安装指南

本文档用于说明如何在 ***Ubuntu 22.04.5 LTS*** 及以上版本中配置 Wave、AOSP、Whale、AriaJDK 的开发环境。

以下命令以 **x86-64 Ubuntu 和 Bash** 为前提。如果只构建 Wave，请按照第 1 节操作；AOSP、Whale 和 AriaJDK 各节是独立的。有关 Linux、macOS 和 Windows 的预编译版本，请参阅 [Wave 安装指南](https://wave-lang.dev/docs/getting-started/install)。

---

## 1. Wave 开发环境

Wave 使用 LLVM 21（[`llvm/Cargo.toml`](https://github.com/wavefnd/Wave/blob/master/llvm/Cargo.toml)）。本指南使用 Rust 1.89.0，与 [Wave CI](https://github.com/wavefnd/Wave/blob/master/tools/ci/toolchains.json) 保持一致。

### 1-1. 安装 LLVM 21（必需）

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
sudo apt install -y llvm-21-dev clang-21 lld-21
```

### 1-2. 配置 LLVM 环境变量

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. 安装 Rust 1.89.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.89.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.89.0
```

### 1-4. 安装 Python（可选，用于 `x.py`）

下面的 Cargo 构建不需要 Python。可选的 `x.py` 工具需要 **Python 3.11 或更高版本**；Ubuntu 22.04 默认的 Python 3.10 不满足要求。使用 `x.py` 前请检查版本；安装 `toml` 包不能替代 Python 的 `tomllib` 模块。

```bash
sudo apt install -y python3
python3 --version
```

### 1-5. 安装 Git

```bash
sudo apt install -y git
```

### 1-6. 安装 IDE（可选）

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. 验证构建

请在打算存放源码的目录中执行以下命令。如果已经克隆了 Wave，请跳过 `git clone` 并进入已有的目录。Rust 版本覆盖设置仅适用于此工作副本。

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

`cargo build --locked` 使用仓库中锁定的依赖版本。开发版编译器位于 `target/debug/wavec`；版本检查命令直接运行该文件，无需全局安装。

---

## 2. AOSP 开发环境

### 2-1. 安装必要软件包

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. 安装 repo

```bash
sudo apt install -y repo
```

AOSP 的配置遵循官方 Android 文档，无需额外依赖。

---

## 3. Whale 开发环境

Whale 仅需安装 Rust 即可。

### 3-1. 安装 Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. 安装 Git

```bash
sudo apt install git
```

---

## 4. AriaJDK 开发环境

AriaJDK 使用 Rust 和 Kotlin。

### 4-1. 安装 Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. 安装 Kotlin 环境

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. 安装 Git

```bash
sudo apt install git
```

---

## 5. 使用安装脚本

请从 **setup 仓库的根目录**运行此可选脚本。它会安装全部四个项目的工具，并更改默认 Rust 工具链。对于当前 Wave 源码的要求，请按照上面第 1 节的手动步骤操作。

```bash
chmod +x install.sh
./install.sh
```
