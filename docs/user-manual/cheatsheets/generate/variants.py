"""Build cheatsheet variants (Colemak-DH/QWERTY x PC/Mac) from keymap-drawer YAML."""
import copy, sys, yaml
from pathlib import Path

src, layout_file, outdir, name = sys.argv[1:5]
data = yaml.safe_load(Path(src).read_text())

CDH = "QWFPBJLUY'ARSTGMNEIOZXCDVKH,./"
QWE = "QWERTYUIOPASDFGHJKL'ZXCVBNM,./"
TO_QWERTY = dict(zip(CDH, QWE))

MODS = {
    "pc": {"LGUI": "Win", "RGUI": "Win", "LALT": "Alt", "RALT": "AltGr",
           "LCTRL": "Ctrl", "RCTRL": "Ctrl", "LSHFT": "Shift", "RSHFT": "Shift"},
    "mac": {"LGUI": "⌘ Cmd", "RGUI": "⌘ Cmd", "LALT": "⌥ Opt", "RALT": "⌥ Opt",
            "LCTRL": "⌃ Ctrl", "RCTRL": "⌃ Ctrl", "LSHFT": "⇧ Shift", "RSHFT": "⇧ Shift"},
}
ESTONIAN = {"Õ", "Ä", "Ö", "Ü"}
# US-International dead keys (with their shifted form where it lives on the same key)
DEAD = {"'": '"', "`": "~", "~": None, "^": None}
LETTER_LAYERS = {"Base", "Gaming-CDH", "default"}


def norm(k):
    return dict(k) if isinstance(k, dict) else {"t": k}


def flat(rows):
    out = []
    for r in rows:
        out.extend(r if isinstance(r, list) else [r])
    return out


def transform(key, layer, layout, os_):
    k = norm(key)
    t = k.get("t", "")
    if layout == "qwerty" and layer in LETTER_LAYERS and isinstance(t, str) and len(t) == 1:
        k["t"] = TO_QWERTY.get(t, t)
        t = k["t"]
    for f in ("t", "h"):
        if isinstance(k.get(f), str) and k[f] in MODS[os_]:
            k[f] = MODS[os_][k[f]]
    if t in ESTONIAN:
        k["type"] = "et"
    elif t in DEAD and os_ == "pc":  # ABC - Extended on macOS has no such dead keys
        k["type"] = "dead"
        if DEAD[t]:
            k["s"] = DEAD[t]
    if k == {"t": ""}:
        return ""
    return k if set(k) != {"t"} else k["t"]


for layout in ("colemak-dh", "qwerty"):
    for os_ in ("pc", "mac"):
        d = copy.deepcopy(data)
        d["layout"] = {"dts_layout": layout_file}
        layers = {}
        for lname, rows in d["layers"].items():
            if layout == "qwerty" and lname == "Gaming-CDH":
                new = "Gaming"
            else:
                new = "Base" if lname == "default" else lname
            layers[new] = [transform(k, lname, layout, os_) for k in flat(rows)]
        d["layers"] = layers
        for c in d.get("combos", []):
            c["k"] = {"t": "Gaming" if layout == "qwerty" and c["k"]["t"] == "Gaming-CDH" else c["k"]["t"],
                      "h": "combo"}
            c["l"] = ["Gaming" if (layout == "qwerty" and l == "Gaming-CDH") else l for l in c["l"]]
        out = Path(outdir) / f"{name}-{layout}-{os_}.yaml"
        out.write_text(yaml.safe_dump(d, allow_unicode=True, sort_keys=False))
        print(out)
