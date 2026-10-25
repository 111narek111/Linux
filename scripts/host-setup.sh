#!/usr/bin/env bash
set -euo pipefail

PKGS=(
  build-essential git openssh-client picocom tree ccache
  gcc-aarch64-linux-gnu g++-aarch64-linux-gnu gdb-multiarch
  device-tree-compiler bc bison flex libssl-dev libelf-dev
)

sudo apt-get update
sudo apt-get install -y "${PKGS[@]}"

if ! id -nG "$USER" | grep -qw dialout; then
  sudo usermod -aG dialout "$USER"
  echo ">> Added $USER to dialout. Log out/in to apply."
else
  echo ">> $USER already in dialout."
fi

echo ">> Toolchain check:"
aarch64-linux-gnu-gcc --version | head -1
gdb-multiarch --version | head -1
dtc --version
