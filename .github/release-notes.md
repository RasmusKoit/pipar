## Which file do I flash?

Download the zip for your keyboard (or `pipar-firmware-*.zip` for all of them) and pick a folder:

```
pipar-point/
├── estonian/        computer set to the Estonian keyboard layout
│   ├── windows/
│   ├── mac/
│   └── linux/
├── international/   computer set to US or US International
│   ├── windows/
│   ├── mac/
│   └── linux/
├── pipar-point-left.uf2
└── pipar-point-settings-reset.uf2
```

1. **Computer layout.** `estonian` if your computer uses the Estonian keyboard layout, the same one as most laptops sold in Estonia. `international` if it uses US or US International.
2. **Operating system.** `windows`, `mac` or `linux`.
3. **Keyboard layout.** Inside that folder, the file ending in `colemak-dh` or `qwerty`. The keyboard does the Colemak-DH or QWERTY mapping, so leave your computer on the layout from step 1.

The cheat sheets are the same for both computer layouts: the firmware sends whatever the computer needs to type the character shown. The [user manual](https://github.com/RasmusKoit/pipar/blob/master/docs/user-manual/README.md) has the cheat sheets and explains how to type Estonian letters.

To flash: connect the part by USB, put it in bootloader mode (double-tap reset on the XIAO-based Sool), and copy the `.uf2` file to the drive that appears.

### Pipar Point

Flash the right half (`pipar-point-right-…`, it holds the keymap) from the folder you picked, and `pipar-point-left.uf2` to the left half. Õ Ä Ö Ü are the outer pinky keys.

### Pipar ja Sool

Flash the dongle (`pipar-sool-dongle-…`, it holds the keymap) from the folder you picked, `pipar-sool-left.uf2` to the left half and `pipar-sool-right.uf2` to the right half. Õ Ä Ö Ü are on the Nav layer: hold Space, then the right-hand top row (Ü Õ Ö Ä).

### Õ Ä Ö Ü keys

- **Estonian:** they are the Estonian layout's own keys and work like any other letter.
- **International:** they are typed with the OS's Unicode input. On Windows that needs [WinCompose](https://github.com/samhocevar/wincompose) running. On macOS, **Unicode Hex Input** must be the active input source (System Settings → Keyboard → Text Input). On Linux, it needs Ctrl+Shift+U Unicode entry (IBus or GTK).

### Pipar Chip and Pipar Flake

`pipar-chip.uf2` and `pipar-flake.uf2`. These keypads have no layout or OS variants.

### On a Mac: keyboard type

macOS asks which keyboard type a new keyboard is, and the answer moves a few keys. To change it later, click **Change Keyboard Type…** in System Settings → Keyboard.

- **Estonian firmware:** choose **ISO (European)**. With ANSI, < types ˇ, > types ~ and | types ¶.
- **International firmware:** choose **ANSI**. With ISO, ` and ~ type § and ±.

Apple's Estonian layout has no ` or ^, so on the Estonian Mac firmware those keys do nothing.

### Settings reset

The `*-settings-reset.uf2` files clear stored settings and Bluetooth pairings. Flash one to each part, then flash the normal firmware again.
