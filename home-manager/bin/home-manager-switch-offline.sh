#!/usr/bin/env bash
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# nix設定
NIX=$(find /nix/store/*/bin -type f -name nix | tail -1)
$NIX profile add ${NIX%/*/*}
. .nix-profile/etc/profile.d/nix.sh

# home-manager設定
HM=$(find /nix/store/*/bin -type f -name home-manager | tail -1)
$HM --impure -b $(date +%F-%H%M) switch
