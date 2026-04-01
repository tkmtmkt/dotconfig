#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
TAG=latest
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# Nixストアディレクトリ作成
sudo mkdir -p -m 0755 /nix
sudo chown ${USER}:${USER} /nix

# Nixインストール
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
nix --version

# home-manager有効化
nix run home-manager -- switch --impure --flake ${BASE_DIR}
