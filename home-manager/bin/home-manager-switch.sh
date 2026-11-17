#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
TAG=latest
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

home-manager --flake ${BASE_DIR} --impure -b $(date +%F-%H%M) switch

# vim: set ft=sh ts=2 sw=2 et:
