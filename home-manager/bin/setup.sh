#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
TAG=latest
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

if [[ ! -d "/nix" ]]; then
  echo "/nix ディレクトリがありません。/nixを作成してから再度実行してください。"
  echo "ディレクトリ作成コマンドは以下の通りとなります。"
  echo "$ sudo mkdir -p -m 0755 /nix"
  echo "$ sudo chown ${USER}:${USER} /nix"
  echo ""
  exit 1
fi

# Nixインストール
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
nix --version

# home-managerインストール
nix run home-manager -- --flake ${BASE_DIR} -b $(date +%F-%H%M) --impure switch

# vim: set ft=sh ts=2 sw=2 et:
