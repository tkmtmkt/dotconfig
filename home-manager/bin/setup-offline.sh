#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
TAG=latest
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

if [[ ! -d "/nix/store" ]]; then
  echo "Nixストアがありません。Nixストアを配置してから再度実行してください。"
  echo ""
  exit 1
fi

# nix設定
NIX=$(ls -dtcr /nix/store/*-nix-[1-9]*[0-9] 2>/dev/null | tail -1)
NIX_MAN=$(ls -dtcr /nix/store/*-nix-[1-9]*[0-9]-man 2>/dev/null | tail -1)
if [[ -z "${NIX}" ]];then
  echo "Nixストアにnixパッケージがありません。"
  echo ""
  exit 1
fi
${NIX}/bin/nix profile add ${NIX} ${NIX_MAN}
. ~/.nix-profile/etc/profile.d/nix.sh
nix --version

# home-manager設定
nix build --offline --impure -o /tmp/result ${BASE_DIR}#homeConfigurations."$USER".activationPackage
/tmp/result/activate

# vim: set ft=sh ts=2 sw=2 et:
