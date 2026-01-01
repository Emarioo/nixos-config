#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

RELEASE_URL=https://github.com/Emarioo/nixos-config/releases/download/wallpapers-0.0.1/wallpapers.tar.gz

wget $RELEASE_URL

tar -xzf wallpapers.tar.gz -C $SCRIPT_DIR

echo Fetched wallpapers:
ls wallpapers

cp wallpapers/frieren-amidst-water-lilies-beyond-journeys-end-moewalls-com.mp4 sddm/astronaut/Backgrounds/
