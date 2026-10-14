#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
set -o errexit
set -o errtrace
#set -o nounset
set -o pipefail
#set -o xtrace

# 引数が指定されていない場合は使い方を表示して終了
if [ -z "$1" ]; then
    echo "使い方: $0 <tarファイル> [解凍先のディレクトリ]"
    exit 1
fi

TAR_FILE="$1"
DEST_DIR="${2:-.}" # 第二引数がない場合はカレントディレクトリ（.）を使用

# ファイルの存在確認
if [ ! -f "$TAR_FILE" ]; then
    echo "エラー: ファイル '$TAR_FILE' が見つかりません。"
    exit 1
fi

EXT=".$(date +%F-%H%M%S)"
[[ -e ~/.config/.git ]]              && mv ~/.config/.git{,$EXT}
[[ -e ~/.config/home-manager ]]      && mv ~/.config/home-manager{,$EXT}
[[ -e ~/.config/nix  ]]              && mv ~/.config/nix{,$EXT}
[[ -e ~/.local/state/home-manager ]] && mv ~/.local/state/home-manager{,$EXT}
[[ -e ~/.local/state/nix ]]          && mv ~/.local/state/nix{,$EXT}

tar -xf "$TAR_FILE" -C ~ \
  .config/.git \
  .config/home-manager \
  .config/nix \
  .local/state/home-manager \
  .local/state/nix \
  .nix-profile \

tar -xf "$TAR_FILE" -C / \
  nix/

# vim: set ft=sh ts=2 sw=2 et:
