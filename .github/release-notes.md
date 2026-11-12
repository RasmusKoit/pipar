## Which file do I flash?

Pick your keyboard, then the layout you type in and your computer's operating system. Keep your computer on a **US** keyboard layout (US International for Estonian letters); the keyboard does the Colemak-DH or QWERTY mapping. The [user manual](https://github.com/RasmusKoit/pipar/blob/master/docs/user-manual/README.md) explains how to type Estonian letters on each OS.

**Pipar Point on macOS:** the Õ Ä Ö Ü keys in the `mac` firmware only work while **Unicode Hex Input** is the active input source (System Settings → Keyboard → Text Input). With other input sources they type the wrong characters.

To flash: connect the part by USB, put it in bootloader mode (double-tap reset on the XIAO-based Sool), and copy the `.uf2` file to the drive that appears.

### Pipar Point

| Half | File |
| --- | --- |
| Right (holds the keymap) | `pipar-point-right-<layout>-<os>.uf2` |
| Left | `pipar-point-left.uf2` |

`<layout>` is `colemak-dh` or `qwerty`, and `<os>` is `win`, `mac` or `linux`. The OS changes how the Õ Ä Ö Ü keys are sent (WinCompose on Windows, Unicode Hex Input on macOS, Ctrl+Shift+U on Linux) and the Mouse layer's Cut/Copy/Paste (⌘X/⌘C/⌘V on macOS).

### Pipar ja Sool

| Part | File |
| --- | --- |
| Dongle (holds the keymap) | `pipar-sool-dongle-<layout>-<os>.uf2` |
| Left half | `pipar-sool-left.uf2` |
| Right half | `pipar-sool-right.uf2` |

The Sool has no keys that depend on the OS, so the `win`, `mac` and `linux` files are the same keymap; pick any one that matches your layout.

### Pipar Chip and Pipar Flake

`pipar-chip.uf2` and `pipar-flake.uf2`. These keypads have no layout or OS variants.

### Settings reset

The `*-settings-reset.uf2` files clear stored settings and Bluetooth pairings. Flash one to each part, then flash the normal firmware again.
