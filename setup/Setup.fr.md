# Guide d’installation de l’environnement de développement

Ce document fournit les instructions pour configurer les environnements de développement de Wave, AOSP, Whale et AriaJDK sur ***Ubuntu 22.04.5 LTS*** ou une version ultérieure.

Les commandes ci-dessous supposent **Ubuntu x86-64 et Bash**. Pour compiler uniquement Wave, suivez la section 1 ; les sections AOSP, Whale et AriaJDK sont indépendantes. Pour les versions précompilées sous Linux, macOS ou Windows, consultez le [guide d’installation de Wave](https://wave-lang.dev/docs/getting-started/install).

---

## 1. Environnement de développement Wave

Wave utilise LLVM 21 ([`llvm/Cargo.toml`](https://github.com/wavefnd/Wave/blob/master/llvm/Cargo.toml)). Ce guide utilise Rust 1.89.0, comme la [CI de Wave](https://github.com/wavefnd/Wave/blob/master/tools/ci/toolchains.json).

### 1-1. Installation de LLVM 21 (obligatoire)

```bash
sudo apt update
sudo apt install -y wget software-properties-common lsb-release gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 21
sudo apt install -y llvm-21-dev clang-21 lld-21
```

### 1-2. Configuration des variables d'environnement LLVM

```bash
echo 'export LLVM_SYS_211_PREFIX=/usr/lib/llvm-21' >> ~/.bashrc
echo 'export LLVM_CONFIG_PATH=/usr/lib/llvm-21/bin/llvm-config' >> ~/.bashrc
source ~/.bashrc
```

### 1-3. Installation de Rust 1.89.0

```bash
sudo apt install -y curl build-essential pkg-config libssl-dev ca-certificates
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.89.0
source "$HOME/.cargo/env"
rustup target add x86_64-unknown-linux-gnu
rustup default 1.89.0
```

### 1-4. Installation de Python (facultative, pour `x.py`)

La compilation avec Cargo ci-dessous ne nécessite pas Python. L’outil facultatif `x.py` nécessite **Python 3.11 ou une version ultérieure** ; Python 3.10 fourni par défaut avec Ubuntu 22.04 ne suffit pas. Vérifiez la version avant d’utiliser `x.py` ; installer le paquet `toml` ne remplace pas le module `tomllib` de Python.

```bash
sudo apt install -y python3
python3 --version
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

Exécutez ces commandes depuis le répertoire où vous souhaitez conserver le code source. Si vous avez déjà une copie de Wave, ignorez `git clone` et placez-vous dans cette copie. La sélection de Rust avec `override` ne s’applique qu’à cette copie.

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

`cargo build --locked` utilise les versions des dépendances enregistrées dans le dépôt. Le compilateur de développement est créé dans `target/debug/wavec` ; la commande de version vérifie directement cet exécutable, sans installation globale.

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

Exécutez ce script facultatif depuis la racine du **dépôt setup**. Il installe les outils des quatre projets et modifie la chaîne d’outils Rust par défaut. Pour les prérequis du code source actuel de Wave, suivez les étapes manuelles de la section 1.

```bash
chmod +x install.sh
./install.sh
```
