#!/usr/bin/env bash
# Regenerate the layout cheatsheet SVGs from the ZMK keymaps.
#
# Needs: Python 3 with keymap-drawer and PyYAML (pip install keymap-drawer),
# and the zmk-keyboard-pipar submodule checked out.
#
#   docs/user-manual/cheatsheets/generate/generate.sh
#
# Writes four SVGs per keyboard into docs/user-manual/cheatsheets/:
# {colemak-dh,qwerty} x {pc,mac}, each drawn from the keymap built the same
# way as that firmware (PIPAR_LAYOUT_*, PIPAR_OS_*). The international and
# Estonian computer-layout firmware type the same characters, so one set of
# sheets covers both. Windows and Linux share the PC sheets.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../../../.." && pwd)"
OUT="$HERE/.."
ZKP="$ROOT/zmk-keyboard-pipar"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

build() { # name keymap layout-dtsi [extra include dir]
  local name=$1 keymap=$2 layout=$3 extra=${4:-}
  for variant in colemak-dh qwerty; do
    for os in pc mac; do
      local v="$name-$variant-$os"
      python3 "$HERE/variants.py" config "$HERE/parse.yaml" "$WORK/$v.parse.yaml" \
        "$variant" "$os" "$ZKP/include" ${extra:+"$extra"}
      keymap -c "$WORK/$v.parse.yaml" parse -z "$keymap" > "$WORK/$v.raw.yaml"
      python3 "$HERE/variants.py" sheet "$WORK/$v.raw.yaml" "$WORK/$v.yaml" "$layout" "$os"
      keymap -c "$HERE/draw.yaml" draw "$WORK/$v.yaml" > "$OUT/$v.svg"
    done
  done
}

build pipar-point \
  "$ZKP/boards/piparkeyboards/pipar_point/pipar_point.keymap" \
  "$ZKP/boards/piparkeyboards/pipar_point/pipar_point_zmk_common.dtsi" \
  "$ZKP/boards/piparkeyboards/pipar_point/include"
build pipar-sool \
  "$ZKP/boards/shields/pipar_sool/pipar_sool.keymap" \
  "$ZKP/boards/shields/pipar_sool/pipar_sool-layouts.dtsi"

echo "Cheatsheets written to $OUT"
