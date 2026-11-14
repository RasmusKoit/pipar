"""Helpers for generate.sh.

  variants.py config BASE.yaml OUT.yaml LAYOUT OS INCLUDE_DIR...
      Write a keymap-drawer config that builds the keymap like the firmware
      variant: LAYOUT is colemak-dh or qwerty, OS is pc or mac.

  variants.py sheet RAW.yaml OUT.yaml LAYOUT_DTSI OS
      Turn a parsed keymap into the cheatsheet: OS-specific modifier names,
      Estonian keys and dead keys marked for colouring.
"""
import sys
from pathlib import Path

import yaml

MODS = {
    "pc": {"LGUI": "Win", "RGUI": "Win", "LALT": "Alt", "RALT": "AltGr",
           "LCTRL": "Ctrl", "RCTRL": "Ctrl", "LSHFT": "Shift", "RSHFT": "Shift"},
    "mac": {"LGUI": "⌘ Cmd", "RGUI": "⌘ Cmd", "LALT": "⌥ Opt", "RALT": "⌥ Opt",
            "LCTRL": "⌃ Ctrl", "RCTRL": "⌃ Ctrl", "LSHFT": "⇧ Shift", "RSHFT": "⇧ Shift"},
}
ESTONIAN = {"Õ", "Ä", "Ö", "Ü"}
# US International dead keys, with the shifted character where it shares the key.
# ABC - Extended on macOS has none of these.
DEAD = {"'": '"', "`": "~", "~": None, "^": None}


def config(base, out, layout, os_, *includes):
    cfg = yaml.safe_load(Path(base).read_text())
    defines = ["PIPAR_HOST_INTERNATIONAL",
               "PIPAR_LAYOUT_QWERTY" if layout == "qwerty" else "PIPAR_LAYOUT_COLEMAK_DH",
               "PIPAR_OS_MAC" if os_ == "mac" else "PIPAR_OS_WIN"]
    pc = cfg.setdefault("parse_config", {})
    pc["zmk_preamble"] = "".join(f"#define {d}\n" for d in defines)
    pc["zmk_additional_includes"] = list(includes)
    Path(out).write_text(yaml.safe_dump(cfg, allow_unicode=True, sort_keys=False))


def key(k, os_):
    k = dict(k) if isinstance(k, dict) else {"t": k}
    for f in ("t", "h"):
        if isinstance(k.get(f), str) and k[f] in MODS[os_]:
            k[f] = MODS[os_][k[f]]
    t = k.get("t", "")
    if t in ESTONIAN:
        k["type"] = "et"
    elif t in DEAD and os_ == "pc":
        k["type"] = "dead"
        if DEAD[t]:
            k["s"] = DEAD[t]
    if k == {"t": ""}:
        return ""
    return k if set(k) != {"t"} else k["t"]


def flat(rows):
    out = []
    for r in rows:
        out.extend(r if isinstance(r, list) else [r])
    return out


def sheet(raw, out, layout_dtsi, os_):
    d = yaml.safe_load(Path(raw).read_text())
    d["layout"] = {"dts_layout": layout_dtsi}
    d["layers"] = {("Base" if name == "default" else name): [key(k, os_) for k in flat(rows)]
                   for name, rows in d["layers"].items()}
    for c in d.get("combos", []):
        c["k"] = {"t": c["k"]["t"] if isinstance(c["k"], dict) else c["k"], "h": "combo"}
    Path(out).write_text(yaml.safe_dump(d, allow_unicode=True, sort_keys=False))


if __name__ == "__main__":
    {"config": config, "sheet": sheet}[sys.argv[1]](*sys.argv[2:])
