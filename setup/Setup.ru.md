# Руководство по установке среды разработки

Этот документ содержит инструкции по настройке сред разработки Wave, AOSP, Whale и AriaJDK на ***Ubuntu 22.04.5 LTS*** или более новой версии.

Приведённые ниже команды рассчитаны на **Ubuntu x86-64 и Bash**. Для сборки только Wave достаточно раздела 1; разделы AOSP, Whale и AriaJDK независимы. Готовые сборки для Linux, macOS и Windows описаны в [руководстве по установке Wave](https://wave-lang.dev/docs/getting-started/install).

---

## 1. Среда разработки Wave

Wave использует LLVM 21 ([`llvm/Cargo.toml`](https://github.com/wavefnd/Wave/blob/master/llvm/Cargo.toml)). В этом руководстве используется Rust 1.89.0, как и в [CI Wave](https://github.com/wavefnd/Wave/blob/master/tools/ci/toolchains.json).

### 1-1. Установка LLVM 21 (обязательно)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
sudo apt install -y llvm-21-dev clang-21 lld-21
```

### 1-2. Настройка переменных окружения LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Установка Rust 1.89.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.89.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.89.0
```

### 1-4. Установка Python (необязательно, для `x.py`)

Для приведённой ниже сборки через Cargo Python не нужен. Необязательный инструмент `x.py` требует **Python 3.11 или новее**; стандартного Python 3.10 в Ubuntu 22.04 недостаточно. Проверьте версию перед использованием `x.py`: установка пакета `toml` не заменяет модуль Python `tomllib`.

```bash
sudo apt install -y python3
python3 --version
```

### 1-5. Установка Git

```bash
sudo apt install -y git
```

### 1-6. Установка IDE (опционально)

```bash
sudo apt install snapd
sudo snap install rustrover --classic
sudo snap install --classic code
```

### 1-7. Проверка сборки

Выполните команды из каталога, в котором хотите хранить исходный код. Если у вас уже есть копия Wave, пропустите `git clone` и перейдите в её каталог. Переопределение версии Rust действует только для этой рабочей копии.

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

`cargo build --locked` использует версии зависимостей, зафиксированные в репозитории. Компилятор для разработки создаётся в `target/debug/wavec`; команда проверки версии запускает этот файл напрямую, без глобальной установки.

---

## 2. Среда разработки AOSP

### 2-1. Установка необходимых пакетов

```bash
sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
```

### 2-2. Установка repo

```bash
sudo apt install -y repo
```

AOSP настраивается согласно официальной документации Android; дополнительные зависимости не требуются.

---

## 3. Среда разработки Whale

Для Whale достаточно установить Rust.

### 3-1. Установка Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 3-2. Установка Git

```bash
sudo apt install git
```

---

## 4. Среда разработки AriaJDK

AriaJDK использует Rust и Kotlin.

### 4-1. Установка Rust

```bash
sudo apt install rustc cargo
rustup target add x86_64-unknown-linux-gnu
rustup default 1.86.0
```

### 4-2. Установка среды Kotlin

```bash
sudo apt install -y wget apt-transport-https gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install -y temurin-17-jdk
sudo snap install kotlin --classic
```

### 4-3. Установка Git

```bash
sudo apt install git
```

---

## 5. Использование установочного скрипта

Запускайте этот необязательный скрипт из корня **репозитория setup**. Он устанавливает инструменты для всех четырёх проектов и меняет набор инструментов Rust по умолчанию. Для актуальных требований исходного кода Wave следуйте ручным шагам раздела 1.

```bash
chmod +x install.sh
./install.sh
```
