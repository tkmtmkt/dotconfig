#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

TAR_FILE="dotconfig-$(date +%F-%H%M%S).tar.gz"
tar -zcf "$TAR_FILE" -C ~ \
  .config/home-manager/ \
  .config/nix/ \
  .config/.git/ \
  .config/.gitignore \
  .config/README.md \
  .local/state/home-manager/ \
  .local/state/nix/ \
  .nix-profile \
  /nix/

# vim: set ft=sh ts=2 sw=2 et:
