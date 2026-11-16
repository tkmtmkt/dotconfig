#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
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
. ~/.nix-profile/etc/profile.d/nix.sh
nix build --offline --impure -o /tmp/result ${BASE_DIR}#homeConfigurations."$USER".activationPackage
/tmp/result/activate
