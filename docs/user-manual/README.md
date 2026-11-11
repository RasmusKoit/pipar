# Pipar user manual

How to use a Pipar keyboard day to day: the layout, the layers, and how to type Estonian letters (õ ä ö ü š ž) on Windows, macOS and Linux.

The manual covers the two full keyboards, the **Pipar Point** and the **Pipar ja Sool**. Both run [ZMK](https://zmk.dev) firmware and use the **Colemak-DH** layout.

- [Cheatsheets](#cheatsheets)
- [Set up your computer](#set-up-your-computer)
- [Typing Estonian letters](#typing-estonian-letters)
  - [Windows](#windows)
  - [macOS](#macos)
  - [Linux](#linux)
- [Pipar Point](#pipar-point)
- [Pipar ja Sool](#pipar-ja-sool)
- [Changing the keymap](#changing-the-keymap)

## Cheatsheets

Each sheet shows every layer of the keyboard. The **PC** sheets label modifiers as Win, Alt, AltGr, Ctrl and Shift. The **Mac** sheets use ⌘ ⌥ ⌃ ⇧.

| Keyboard | Colemak-DH | QWERTY |
| --- | --- | --- |
| Pipar Point | [PC](cheatsheets/pipar-point-colemak-dh-pc.svg) · [Mac](cheatsheets/pipar-point-colemak-dh-mac.svg) | [PC](cheatsheets/pipar-point-qwerty-pc.svg) · [Mac](cheatsheets/pipar-point-qwerty-mac.svg) |
| Pipar ja Sool | [PC](cheatsheets/pipar-sool-colemak-dh-pc.svg) · [Mac](cheatsheets/pipar-sool-colemak-dh-mac.svg) | [PC](cheatsheets/pipar-sool-qwerty-pc.svg) · [Mac](cheatsheets/pipar-sool-qwerty-mac.svg) |

On the sheets:

- **Yellow keys** are the Estonian letters Õ Ä Ö Ü.
- **Blue dashed keys** (PC sheets only) are US-International dead keys (`'` `"` `` ` `` `~` `^`). See [dead keys](#what-a-dead-key-is).
- **Small text at the bottom** of a key is what it does when held, for example Shift or a layer name.
- **Small text at the top** is what it does with Shift.
- **Small tags between two keys** are combos: press both keys together.
- **The pink key** on each layer is the thumb key you hold to reach that layer.

The sheets switch to dark colours when your system is in dark mode, and print in black on white.

> [!NOTE]
> The firmware is Colemak-DH. The QWERTY sheets show the same keymap with the letters moved to QWERTY positions, for people who remap their board. In the QWERTY version, `'` moves to the right home-row pinky key. On the Point, `;` is on the Num layer. The sheets are generated from the keymaps, so they always match the firmware. To regenerate them, run `cheatsheets/generate/generate.sh`.

## Set up your computer

The keyboard does the Colemak-DH remapping itself. **Leave your computer on a US layout.** If you also set the computer to Colemak, the letters get remapped twice and come out wrong.

For Estonian letters, use **US International** (Windows, Linux) or **ABC – Extended** (macOS). The sections below explain both.

### What a dead key is

On US International, these keys don't type anything straight away:

- `'` (apostrophe)
- `"` (Shift + `'`)
- `` ` `` (backtick)
- `~` (Shift + `` ` ``)
- `^` (Shift + 6)

They wait for the next key and combine with it: `"` then `a` gives **ä**. To type the symbol itself, press **Space** after it: `"` then Space gives a plain `"`.

This catches most people out when writing code or English text. If it gets in your way, add the plain US layout as well and switch between the two: Win + Space on Windows, or your desktop's layout switcher on Linux. The plain US layout has no Estonian letters at all, so switch back to type them.

## Typing Estonian letters

### Windows

Add the layout under **Settings → Time & language → Language & region → English (United States) → Language options → Add a keyboard → United States-International**.

| Letter | Dead key | AltGr shortcut |
| --- | --- | --- |
| ä / Ä | `"` then `a` / `A` | AltGr + Q (with Shift for Ä) |
| ö / Ö | `"` then `o` / `O` | AltGr + P (with Shift for Ö) |
| ü / Ü | `"` then `u` / `U` | AltGr + Y (with Shift for Ü) |
| õ / Õ | `~` then `o` / `O` | none |
| š / Š | not available | not available |
| ž / Ž | not available | not available |

**Where AltGr is.** AltGr is Right Alt.

- **On the Point:** hold **I** (right home row) or **X** (left bottom row). [Home-row modifiers](#home-row-modifiers) only work with a key on the other hand, so:
  - for **ä** (Q) and **ö** (P), hold **I**;
  - for **ü** (Y), hold **X**.
- **On the Sool:** hold **.** (full stop).

**AltGr follows the letter, not the position.** The keyboard sends the letter printed on the key, so AltGr + Q means the key labelled **Q**, wherever it sits on Colemak-DH.

**š and ž.** US International can't type these. Install [WinCompose](https://github.com/samhocevar/wincompose) and type **Compose, c, s** for š or **Compose, c, z** for ž. WinCompose also makes the Point's own [Estonian keys](#estonian-keys) work.

<!-- TODO: verify whether WinCompose on Right Alt blocks the AltGr shortcuts on US International, and document the workaround (e.g. a different compose key). -->

### macOS

Add the input source under **System Settings → Keyboard → Text Input → Edit… → + → English → ABC – Extended**. It is the only built-in US-based input source that types all six letters. macOS also has an Estonian input source, but it moves punctuation around and expects Estonian keycaps.

| Letter | Keys (ABC – Extended) |
| --- | --- |
| ä / Ä | ⌥U, then `a` / `A` |
| ö / Ö | ⌥U, then `o` / `O` |
| ü / Ü | ⌥U, then `u` / `U` |
| õ / Õ | ⌥N, then `o` / `O` |
| š / Š | ⌥V, then `s` / `S` |
| ž / Ž | ⌥V, then `z` / `Z` |

**Where ⌥ (Option) is.**

- **On the Point:** hold **R** or **X** (left) or **I** (right). [Home-row modifiers](#home-row-modifiers) only work with a key on the other hand, so:
  - for ⌥U and ⌥N, hold **R**;
  - for ⌥V, hold **I**.
- **On the Sool:** hold **.** (full stop).

**Press and hold.** On the Sool, you can also hold a letter and pick from the pop-up: hold `s` to get š, hold `o` to get õ or ö. This doesn't work on the Point's home-row letters (A R S T N E I O), because holding them gives a modifier.

**U.S. International – PC.** This input source also works and behaves like Windows, with `"` and `~` as dead keys. Like Windows, it has no š or ž.

**Copy and paste.** Use ⌘X, ⌘C and ⌘V. On the Point, hold **O** for ⌘, then tap X, C or V with the left hand. (Holding A doesn't work here, because A, X, C and V are all on the left half.)

<!-- TODO: test every row of the table on a real Mac before publishing. -->

### Linux

Choose **English (US, intl., with dead keys)** in your desktop's keyboard settings, or run `setxkbmap us -variant intl`.

| Letter | Dead key | AltGr shortcut |
| --- | --- | --- |
| ä / Ä | `"` then `a` | AltGr + Q |
| ö / Ö | `"` then `o` | AltGr + P |
| ü / Ü | `"` then `u` | AltGr + Y |
| õ / Õ | `~` then `o` | none |
| š / Š | AltGr + Shift + `.` then `s` / `S` | Compose, c, s |
| ž / Ž | AltGr + Shift + `.` then `z` / `Z` | Compose, c, z |

**š and ž.** AltGr + Shift + `.` is a caron (ˇ) dead key. On the Point, hold **X** (AltGr) and **T** (Shift) with the left hand, then tap `.` with the right.

**Compose key.** A Compose key is an easier alternative. Turn one on, for example in GNOME Tweaks → Keyboard → Compose Key, or with `setxkbmap -option compose:menu`. On the Point, the **Menu** key is on the Fun layer: hold Del, then tap the left thumb key where Esc is.

<!-- TODO: test the X+T+. chord on the Point; two left-hand home-row mods held together should both resolve as holds when the right-hand key is pressed. -->

<!-- TODO: verify the Point's unicode keys on Linux after switching mode (see below). -->

## Pipar Point

40 keys, an optional trackpoint on the right half, and Bluetooth to up to four devices.

![Pipar Point, Colemak-DH, PC labels](cheatsheets/pipar-point-colemak-dh-pc.svg)

### Thumb keys and layers

Each thumb key types one thing when tapped and switches to a layer while held.

| Thumb key | Tap | Hold |
| --- | --- | --- |
| Left outer | Esc | **Media**: Bluetooth, volume, lights |
| Left middle | Space | **Nav**: arrows, Home/End, Page Up/Down |
| Left inner | Tab | **Mouse**: clicks and Cut/Copy/Paste for the trackpoint |
| Right inner | Enter | **Sym**: symbols |
| Right middle | Backspace | **Num**: numbers |
| Right outer | Del | **Fun**: F-keys, Print Screen, Menu |

### Home-row modifiers

Hold a home-row key to use it as a modifier. Tap it to type the letter.

| Left hand | | Right hand | |
| --- | --- | --- | --- |
| A | Win / ⌘ | N | Shift / ⇧ |
| R | Alt / ⌥ | E | Ctrl / ⌃ |
| S | Ctrl / ⌃ | I | AltGr / ⌥ |
| T | Shift / ⇧ | O | Win / ⌘ |

Two rules stop fast typing from triggering modifiers by accident:

- **Other hand only.** A modifier only counts as held when you press a key on the **other** half, or a thumb key, while holding it. For a shortcut, hold the modifier on one hand and press the key with the other. For example, for Ctrl+C, hold **E** (right Ctrl) and tap **C**.
- **Typing streak.** A home-row key pressed within 150 ms of the previous key always types its letter.

The X key (left bottom row) also gives AltGr / ⌥ when held, and the full stop gives Alt / ⌥.

### Estonian keys

The outer pinky keys type Estonian letters directly:

- **Left half:** Ü (middle row) and Ö (bottom row).
- **Right half:** Õ (middle row) and Ä (bottom row).

Hold Shift for the capital letter.

These keys send the character as a Unicode code, which your computer has to know how to read. **By default they are set up for Windows with WinCompose installed**, using Right Alt as the compose key.

- **Windows:** install [WinCompose](https://github.com/samhocevar/wincompose) and keep its default compose key (Right Alt).
- **macOS and Linux:** in the default firmware, **don't use these keys.** They type something like `uf5` and then press **Enter**, which can send a half-written message in a chat app. Use the [ABC – Extended](#macos) or [US International](#linux) method instead.
  - The firmware can switch Unicode mode with `&uc UC_SET_MACOS` or `&uc UC_SET_LINUX` keys, but the default keymap has no such key yet. On macOS, this mode also needs the **Unicode Hex Input** input source, which may disable some ⌥ shortcuts.

### Bluetooth

Hold **Esc** to reach the Media layer, then:

- **BT 1–4** (right bottom row) switch between up to four paired devices.
- **Shift + BT n** clears that slot and starts pairing a new device in it.
- **USB/BT** switches output between the USB cable and Bluetooth.
- **Clear all BT** (right top corner) forgets every paired device.

<!-- TODO: add charging, battery life, LED meanings (connection, caps, low battery), and how the halves pair with each other. -->

### Trackpoint

If your Point has a trackpoint, move the pointer with it. Hold **Tab** (left thumb), and the right thumb keys become **left click, middle click and right click**.

<!-- TODO: the Mouse layer's Cut/Copy/Paste sit on the left thumb keys, and Paste is under Tab itself, so they can't be used while Tab is held. Move them in the firmware, then document them. -->

### Gaming layer

The Gaming-CDH layer makes the left half behave like a plain keyboard, so held keys stay letters in games:

- Home-row modifiers on the left half are off, and X no longer gives AltGr.
- The left thumb keys are plain Esc, Space and Tab, with no Media, Nav or Mouse layer.
- Z works as Shift when held.
- The right half is unchanged, except that the full stop no longer gives Alt.

The layer is still Colemak-DH, so the keys in the usual WASD positions send W, A, R and S. Rebind movement in the game, or press the keys labelled W, A, S and D.

- **Turn it on:** hold **Del** (Fun) and press the right pinky **Õ** and **Ä** keys together.
- **Turn it off:** press **Õ** and **Ä** together again.

### Caps Word

On the Nav layer (hold Space), the key left of the arrows is **Caps Word**. It types the next word in capitals and then switches itself off. Shift + Caps Word gives regular Caps Lock.

## Pipar ja Sool

36 keys. With the dongle build, plug the dongle in and both halves connect to it, so there is no pairing. There is also a build without a dongle, where the right half connects to the computer directly.

![Pipar ja Sool, Colemak-DH, PC labels](cheatsheets/pipar-sool-colemak-dh-pc.svg)

The default keymap has a single layer: the letters, `'` `,` `.` `;`, Esc, Space, Tab, Enter and Backspace. Hold **.** (full stop) for AltGr or ⌥. **There is no Shift, and no numbers or symbols.**

[ZMK Studio](#changing-the-keymap) can change what each of these keys does, but it can't add layers. To get Shift, numbers and symbols, you need to rebuild the firmware.

**Estonian letters on the Sool.** With no Shift, only lowercase letters are possible:

- **Windows and Linux:** AltGr + Q, P and Y give **ä, ö and ü**. There's no way to type **õ**, because `~` needs Shift.
- **macOS:** ⌥U then a, o or u gives **ä, ö and ü**. ⌥N then o gives **õ**. ⌥V then s or z gives **š and ž**.

<!-- TODO: ship the Sool with layers (Shift, numbers, symbols) and some `status = "reserved"` layers so Studio can add more. Then rewrite this section. -->

## Changing the keymap

Both keyboards support [ZMK Studio](https://zmk.studio), which lets you change keys in your browser without rebuilding the firmware:

- **Pipar Point:** connect the right half by USB and unlock it with the **Studio unlock** key on the Fun layer.
- **Pipar ja Sool:** connect the dongle (or, without a dongle, the right half) by USB and unlock it with the **Studio unlock** key (right outer thumb).

Studio can change existing keys. It can only add layers if the firmware has spare reserved layers, and neither keyboard's default keymap has any yet.

To change the default keymap for everyone, edit the `.keymap` files in [zmk-keyboard-pipar](https://github.com/RasmusKoit/zmk-keyboard-pipar) and rebuild the firmware. See the [main README](../../README.md#firmware) for build steps.
