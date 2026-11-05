#!/usr/bin/env bash
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# nix設定
NIX=$(ls -dtcr /nix/store/*-nix-[1-9]*[0-9] 2>/dev/null | tail -1)
NIX_MAN=$(ls -dtcr /nix/store/*-nix-[1-9]*[0-9]-man 2>/dev/null | tail -1)
$NIX/bin/nix profile add $NIX $NIX_MAN

# home-manager設定
HM=$(ls -tcr /nix/store/*-home-manager/bin/home-manager 2>/dev/null | tail -1)
. .nix-profile/etc/profile.d/nix.sh
$HM --impure -b $(date +%F-%H%M) switch
