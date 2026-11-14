# Pipar user manual

How to use a Pipar keyboard day to day: which firmware to flash, the layout and layers, and how to type Estonian letters (õ ä ö ü š ž) on Windows, macOS and Linux.

The manual covers the two full keyboards, the **Pipar Point** and the **Pipar ja Sool**. Both run [ZMK](https://zmk.dev) firmware and share the same keymap: Colemak-DH or QWERTY, home-row modifiers and thumb-key layers.

- [Choose your firmware](#choose-your-firmware)
- [Cheatsheets](#cheatsheets)
- [Estonian computer layout](#estonian-computer-layout)
- [International computer layout](#international-computer-layout)
  - [Windows](#windows)
  - [macOS](#macos)
  - [Linux](#linux)
- [Using the keyboards](#using-the-keyboards)
- [Pipar Point](#pipar-point)
- [Pipar ja Sool](#pipar-ja-sool)
- [Changing the keymap](#changing-the-keymap)

## Choose your firmware

Download the firmware from the [releases page](https://github.com/RasmusKoit/pipar/releases). Each keyboard's zip has a folder for every combination of three choices:

1. **Computer layout:** the keyboard layout selected on your computer.
   - **`estonian`:** your computer uses the Estonian layout, like most laptops sold in Estonia. Recommended if you type Estonian.
   - **`international`:** your computer uses US or US International.
2. **Operating system:** `windows`, `mac` or `linux`.
3. **Keyboard layout:** the file ending in `colemak-dh` or `qwerty`. The keyboard does the Colemak-DH or QWERTY mapping itself, so leave your computer on the layout from step 1. If you also switch the computer to Colemak, the letters get remapped twice and come out wrong.

The keyboard sends each symbol the way your computer's layout expects, so every key types what the [cheatsheets](#cheatsheets) show on both computer layouts. The difference is how the Estonian letters work:

| | Estonian | International |
| --- | --- | --- |
| Computer layout | Estonian | US or US International |
| Õ Ä Ö Ü keys | Work like any other letter | Need your OS's Unicode input (see [below](#international-computer-layout)) |
| š ž | AltGr + S / Z (⌥S / ⌥Z on a Mac) | Depends on the OS |
| macOS keyboard type | ISO (European) | ANSI |

The zip's `README.md` lists which file goes to which part of the keyboard and how to flash it.

> [!IMPORTANT]
> **On a Mac, set the keyboard type.** macOS asks which keyboard type a new keyboard is, and the answer moves a few keys. Choose **ISO (European)** for the Estonian firmware and **ANSI** for the international firmware. To change it later, click **Change Keyboard Type…** in System Settings → Keyboard. With the wrong type, `<` `>` `|` (Estonian) or `` ` `` `~` (international) type the wrong character.

## Cheatsheets

Each sheet shows every layer of the keyboard. The **PC** sheets (Windows and Linux) label modifiers as Win, Alt, AltGr, Ctrl and Shift. The **Mac** sheets use ⌘ ⌥ ⌃ ⇧. The sheets are the same for the Estonian and international firmware.

| Keyboard | Colemak-DH | QWERTY |
| --- | --- | --- |
| Pipar Point | [PC](cheatsheets/pipar-point-colemak-dh-pc.svg) · [Mac](cheatsheets/pipar-point-colemak-dh-mac.svg) | [PC](cheatsheets/pipar-point-qwerty-pc.svg) · [Mac](cheatsheets/pipar-point-qwerty-mac.svg) |
| Pipar ja Sool | [PC](cheatsheets/pipar-sool-colemak-dh-pc.svg) · [Mac](cheatsheets/pipar-sool-colemak-dh-mac.svg) | [PC](cheatsheets/pipar-sool-qwerty-pc.svg) · [Mac](cheatsheets/pipar-sool-qwerty-mac.svg) |

On the sheets:

- **Yellow keys** are the Estonian letters Õ Ä Ö Ü.
- **Blue dashed keys** (PC sheets only) are dead keys if your computer is on US International: `'` `"` `` ` `` `~` `^`. See [dead keys](#dead-keys).
- **Small text at the bottom** of a key is what it does when held, for example Shift or a layer name.
- **Small text at the top** is what it does with Shift.
- **Small tags between two keys** are combos: press both keys together.
- **The pink key** on each layer is the thumb key you hold to reach that layer.

The sheets switch to dark colours when your system is in dark mode, and print in black on white. They are generated from the keymaps, so they always match the firmware. To regenerate them, run `cheatsheets/generate/generate.sh`.

> [!NOTE]
> The manual names keys by their **Colemak-DH** letter, with the QWERTY letter in brackets where it differs. For example, "hold **I** [L]" means the right ring-finger home-row key.

## Estonian computer layout

With the `estonian` firmware, select the Estonian keyboard layout on your computer:

- **Windows:** Settings → Time & language → Language & region → add **Estonian**, or add the **Estonian** keyboard to your existing language.
- **macOS:** System Settings → Keyboard → Text Input → Edit… → + → **Estonian**. Set the keyboard type to **ISO** (see [above](#choose-your-firmware)).
- **Linux:** choose **Estonian** in your desktop's keyboard settings, or run `setxkbmap ee`. Use the plain "Estonian" layout, not "Estonian (no dead keys)": with that one, `~` types `~` followed by a space.

That's all the setup. Õ Ä Ö Ü are ordinary keys, and Shift and Caps Lock work with them. [Caps Word](#caps-word) stops at them, as it does on the international firmware, so use Caps Lock for a word in capitals that contains one.

| Letter | Keys |
| --- | --- |
| õ ä ö ü | The Õ Ä Ö Ü keys: outer pinky keys on the Point, Nav layer on the Sool |
| š / Š | AltGr + S, with Shift for Š (⌥S on a Mac) |
| ž / Ž | AltGr + Z, with Shift for Ž (⌥Z on a Mac) |

For where AltGr and ⌥ are, see [home-row modifiers](#home-row-modifiers).

**Limits of the Estonian firmware:**

- **Mac, `` ` `` and `^`:** Apple's Estonian layout has neither character, so those keys do nothing. If you need them, for example for programming, use the international Mac firmware with **ABC – Extended** instead.
- **Shift on the Num layer:** Shift + a digit types what it does on an Estonian laptop. For example, Shift + 2 types `"`, not `@`. Use the Sym layer for symbols.
- **`<` and capitals:** if you're still holding `<` when you press Shift + a letter, the letter comes out lowercase. `"` `>` and `?` don't have this problem.

## International computer layout

With the `international` firmware, keep your computer on **US**, **US International** or, on a Mac, **ABC** or **ABC – Extended**.

The Õ Ä Ö Ü keys type each letter by its Unicode code, through an input method your OS has to have switched on. The firmware for each OS uses that OS's method:

| OS | What it needs | What the key types without it |
| --- | --- | --- |
| Windows | [WinCompose](https://github.com/samhocevar/wincompose) running, with its default compose key (Right Alt) | `u` and a code, then **Enter**, which can send a half-written chat message |
| macOS | **Unicode Hex Input** as the active input source | Odd characters, from ⌥ + the digits of the code |
| Linux | Ctrl+Shift+U Unicode entry, which IBus and GTK apps have (GNOME has it by default) | Depends on the app |

If you'd rather not set that up, type the letters with your layout's own keys instead, as described below for each OS.

### Dead keys

On US International, these keys don't type anything straight away:

- `'` (apostrophe)
- `"` (Shift + `'`)
- `` ` `` (backtick)
- `~` (Shift + `` ` ``)
- `^`

They wait for the next key and combine with it: `"` then `a` gives **ä**. To type the symbol itself, press **Space** after it: `"` then Space gives a plain `"`.

This catches most people out when writing code or English text. If it gets in your way, use the plain US layout and the Õ Ä Ö Ü keys.

### Windows

- **Õ Ä Ö Ü keys:** install [WinCompose](https://github.com/samhocevar/wincompose) and keep its default compose key (Right Alt).
- **š and ž:** with WinCompose running, type **Compose, c, s** for š or **Compose, c, z** for ž. The compose key is Right Alt, which is AltGr on the keyboard (see [home-row modifiers](#home-row-modifiers)).

Without WinCompose, add **United States-International** under Settings → Time & language → Language & region → English (United States) → Language options → Add a keyboard. Then:

| Letter | Dead key | AltGr shortcut |
| --- | --- | --- |
| ä / Ä | `"` then `a` / `A` | AltGr + Q (with Shift for Ä) |
| ö / Ö | `"` then `o` / `O` | AltGr + P (with Shift for Ö) |
| ü / Ü | `"` then `u` / `U` | AltGr + Y (with Shift for Ü) |
| õ / Õ | `~` then `o` / `O` | none |
| š ž | not available | not available |

**AltGr follows the letter, not the position.** The keyboard sends the letter printed on the key, so AltGr + Q means the key labelled **Q**, wherever it sits on Colemak-DH.

<!-- TODO: verify whether WinCompose on Right Alt blocks the AltGr shortcuts on US International, and document the workaround (e.g. a different compose key). -->

### macOS

**Õ Ä Ö Ü keys:** add **Unicode Hex Input** under System Settings → Keyboard → Text Input → Edit… → + → Others, and make it the active input source. It types like the US layout, but ⌥ + letter no longer types special characters, so ⌥U and the shortcuts below don't work with it. To type š with it, hold ⌥ and type `0161` (ž is `017E`).

The alternative is **ABC – Extended** (Edit… → + → English). It is the only built-in US-based input source that types all six letters, without the Õ Ä Ö Ü keys:

| Letter | Keys (ABC – Extended) |
| --- | --- |
| ä / Ä | ⌥U, then `a` / `A` |
| ö / Ö | ⌥U, then `o` / `O` |
| ü / Ü | ⌥U, then `u` / `U` |
| õ / Õ | ⌥N, then `o` / `O` |
| š / Š | ⌥V, then `s` / `S` |
| ž / Ž | ⌥V, then `z` / `Z` |

**Press and hold.** You can also hold a letter and pick from the pop-up: hold `s` to get š, hold `o` to get õ or ö. This doesn't work on the home-row letters, because holding them gives a modifier.

**U.S. International – PC** also works and behaves like Windows, with `"` and `~` as dead keys. Like Windows, it has no š or ž.

<!-- TODO: test every row of the table, and the Õ Ä Ö Ü keys with Unicode Hex Input, on a real Mac before publishing. -->

### Linux

**Õ Ä Ö Ü keys:** these use Ctrl+Shift+U, then the code, then Space. That works in GTK apps and anywhere IBus is running, which is the default on GNOME. Some other apps and desktops ignore it.

For š, ž and the dead-key method, choose **English (US, intl., with dead keys)** in your desktop's keyboard settings, or run `setxkbmap us -variant intl`:

| Letter | Dead key | AltGr shortcut |
| --- | --- | --- |
| ä / Ä | `"` then `a` | AltGr + Q |
| ö / Ö | `"` then `o` | AltGr + P |
| ü / Ü | `"` then `u` | AltGr + Y |
| õ / Õ | `~` then `o` | none |
| š / Š | AltGr + Shift + `.` then `s` / `S` | Compose, c, s |
| ž / Ž | AltGr + Shift + `.` then `z` / `Z` | Compose, c, z |

**š and ž.** AltGr + Shift + `.` is a caron (ˇ) dead key. Hold AltGr on the left with **X** and Shift with **T** [F], then tap `.` with the right hand.

**Compose key.** A Compose key is an easier alternative. Turn one on, for example in GNOME Tweaks → Keyboard → Compose Key, or with `setxkbmap -option compose:menu`. The **Menu** key is on the Fun layer: hold Del, then tap the left outer thumb key.

<!-- TODO: test the X+T+. chord; two left-hand home-row mods held together should both resolve as holds when the right-hand key is pressed. -->

## Using the keyboards

The Point and the Sool share the same layout, home-row modifiers and layers. The Point adds an outer pinky column with the Estonian letters, a Mouse layer for the trackpoint, and backlight keys.

### Thumb keys and layers

Each thumb key types one thing when tapped and switches to a layer while held.

| Thumb key | Tap | Hold |
| --- | --- | --- |
| Left outer | Esc | **Media**: Bluetooth, volume, and lights on the Point |
| Left middle | Space | **Nav**: arrows, Home/End, Page Up/Down. On the Sool, also Ü Õ Ö Ä |
| Left inner | Tab | **Mouse** (Point only): clicks and Cut/Copy/Paste for the trackpoint |
| Right inner | Enter | **Sym**: symbols |
| Right middle | Backspace | **Num**: numbers |
| Right outer | Del | **Fun**: F-keys, Print Screen, Menu |

### Home-row modifiers

Hold a home-row key to use it as a modifier. Tap it to type the letter.

| Left hand | | Right hand | |
| --- | --- | --- | --- |
| A | Win / ⌘ | N [J] | Shift / ⇧ |
| R [S] | Alt / ⌥ | E [K] | Ctrl / ⌃ |
| S [D] | Ctrl / ⌃ | I [L] | AltGr / ⌥ |
| T [F] | Shift / ⇧ | O [`'`] | Win / ⌘ |

Two rules stop fast typing from triggering modifiers by accident:

- **Other hand only.** A modifier only counts as held when you press a key on the **other** half, or a thumb key, while holding it. For a shortcut, hold the modifier on one hand and press the key with the other. For example, for Ctrl+C, hold **E** [K] (right Ctrl) and tap **C**.
- **Typing streak.** A home-row key pressed within 150 ms of the previous key always types its letter.

**X** (left bottom row) also gives AltGr / ⌥ when held, and the **full stop** gives Alt / ⌥. So for AltGr + a left-hand letter, hold **I** [L]; for a right-hand letter, hold **X**.

### Caps Word

On the Nav layer (hold Space), the key left of the arrows is **Caps Word**. It types the next word in capitals and then switches itself off. Shift + Caps Word gives regular Caps Lock.

### Gaming layer

The gaming layer makes the left half behave like a plain keyboard, so held keys stay letters in games:

- Home-row modifiers on the left half are off, and X no longer gives AltGr.
- The left thumb keys are plain Esc, Space and Tab, with no Media, Nav or Mouse layer.
- Z works as Shift when held.
- The right half is unchanged, except that the full stop no longer gives Alt.

On the Colemak-DH firmware the layer is called **Gaming-CDH** and stays Colemak-DH, so the keys in the usual WASD positions send W, A, R and S. Rebind movement in the game, or press the keys labelled W, A, S and D. On the QWERTY firmware it's called **Gaming** and WASD is where you expect.

To turn it on, hold **Del** (Fun) and press the combo below. Press the same combo again to turn it off.

- **Point:** the right outer pinky keys **Õ** and **Ä** together.
- **Sool:** the right pinky home-row and bottom-row keys together: **O** and **/** [`'` and **/**].

### Bluetooth

Hold **Esc** to reach the Media layer, then:

- **BT 1–4** (right bottom row) switch between up to four paired devices.
- **Shift + BT n** clears that slot and starts pairing a new device in it.
- **USB/BT** switches output between the USB cable and Bluetooth.
- **Clear all BT** (right top corner) forgets every paired device.

## Pipar Point

40 keys, an optional trackpoint on the right half, and Bluetooth to up to four devices.

![Pipar Point, Colemak-DH, PC labels](cheatsheets/pipar-point-colemak-dh-pc.svg)

### Estonian keys

The outer pinky keys type Estonian letters:

- **Left half:** Ü (middle row) and Ö (bottom row).
- **Right half:** Õ (middle row) and Ä (bottom row).

Hold Shift for the capital letter. On the Estonian firmware they are ordinary keys. On the international firmware they need your OS's [Unicode input](#international-computer-layout).

<!-- TODO: add charging, battery life, LED meanings (connection, caps, low battery), and how the halves pair with each other. -->

### Trackpoint

If your Point has a trackpoint, move the pointer with it. Hold **Tab** (left thumb), and the right thumb keys become **left click, middle click and right click**.

<!-- TODO: the Mouse layer's Cut/Copy/Paste sit on the left thumb keys, and Paste is under Tab itself, so they can't be used while Tab is held. Move them in the firmware, then document them. -->

## Pipar ja Sool

36 keys. Plug the dongle into your computer and both halves connect to it, so there is no pairing between the halves.

![Pipar ja Sool, Colemak-DH, PC labels](cheatsheets/pipar-sool-colemak-dh-pc.svg)

### Estonian letters

The Sool has no outer pinky column, so Õ Ä Ö Ü are on the **Nav layer**. Hold **Space** with the left thumb, then press the right-hand top row:

| Key | J [Y] | L [U] | U [I] | Y [O] |
| --- | --- | --- | --- | --- |
| Nav layer | Ü | Õ | Ö | Ä |

For a capital, also hold Shift on the left hand (**T** [F]). Like on the Point, they are ordinary keys on the Estonian firmware and use your OS's [Unicode input](#international-computer-layout) on the international firmware.

## Changing the keymap

Both keyboards support [ZMK Studio](https://zmk.studio), which lets you change keys in your browser without rebuilding the firmware:

- **Pipar Point:** connect the right half by USB and unlock it with the **Studio unlock** key on the Fun layer.
- **Pipar ja Sool:** connect the dongle by USB and unlock it with the **Studio unlock** key on the Fun layer.

Studio can change existing keys. It can only add layers if the firmware has spare reserved layers, and neither keyboard's default keymap has any yet.

To change the default keymap for everyone, edit the `.keymap` files in [zmk-keyboard-pipar](https://github.com/RasmusKoit/zmk-keyboard-pipar) and rebuild the firmware. See the [main README](../../README.md#firmware) for build steps.
