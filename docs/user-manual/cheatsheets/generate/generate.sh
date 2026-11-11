#!/usr/bin/env bash
# Regenerate the layout cheatsheet SVGs from the ZMK keymaps.
#
# Needs: Python 3 with keymap-drawer and PyYAML (pip install keymap-drawer),
# and the zmk-keyboard-pipar submodule checked out.
#
#   docs/user-manual/cheatsheets/generate/generate.sh
#
# Writes four SVGs per keyboard into docs/user-manual/cheatsheets/:
# {colemak-dh,qwerty} x {pc,mac}. The QWERTY sheets are drawn from the
# Colemak-DH keymap with the letters moved; the firmware itself is Colemak-DH.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../../../.." && pwd)"
OUT="$HERE/.."
ZKP="$ROOT/zmk-keyboard-pipar/boards"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

build() { # name keymap layout-dtsi
  local name=$1 keymap=$2 layout=$3
  keymap -c "$HERE/parse.yaml" parse -z "$keymap" > "$WORK/$name.raw.yaml"
  python3 "$HERE/variants.py" "$WORK/$name.raw.yaml" "$layout" "$WORK" "$name" > /dev/null
  for f in "$WORK/$name"-*.yaml; do
    keymap -c "$HERE/draw.yaml" draw "$f" > "$OUT/$(basename "${f%.yaml}").svg"
  done
}

build pipar-point \
  "$ZKP/piparkeyboards/pipar_point/pipar_point.keymap" \
  "$ZKP/piparkeyboards/pipar_point/pipar_point_zmk_common.dtsi"
build pipar-sool \
  "$ZKP/shields/pipar_sool/pipar_sool.keymap" \
  "$ZKP/shields/pipar_sool/pipar_sool-layouts.dtsi"

echo "Cheatsheets written to $OUT"
