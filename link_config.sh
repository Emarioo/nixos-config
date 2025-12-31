#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


HOST=lapis
if [ $# -gt 1 ]; then
    HOST=$1
fi

TARGET="$SCRIPT_DIR/hosts/$HOST/configuration.nix"
DEST="/etc/nixos/configuration.nix"

# Check if destination exists and is not a symlink
if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
    echo "/etc/nixos/configuration.nix -> /etc/nixos/_configuration.nix"
    sudo mv "$DEST" "/etc/nixos/_configuration.nix"
fi

# Remove old symlink if it exists
if [ -L "$DEST" ]; then
    sudo rm "$DEST"
fi

# Create new symlink
sudo ln -s "$TARGET" "$DEST"
echo "Made symlink"
ls -lh /etc/nixos
