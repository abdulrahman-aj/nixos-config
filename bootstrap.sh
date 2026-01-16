#!/usr/bin/env bash

set -euo pipefail
cp /etc/nixos/hardware-configuration.nix .
sudo nixos-rebuild switch --flake .#nixos
