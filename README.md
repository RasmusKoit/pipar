# Pipar PCBs

**Pipar** is a collection of different keyboards and keypads that I have designed. Each PCB in the series has unique features tailored to different needs and preferences.

## Designed PCBs

Currently, both Pipar and Pipar Flake are designed to be manufactured together but used separately. Both PCBs are designed to be used with Choc switches and hotswap sockets. The PCBs are wireless.

### Pipar

The **Pipar** is a 36-key split wireless keyboard with a 3x5+3 layout. It features:

- **Microcontrollers**: XIAO BLE for both halves and a dongle.
- **Switches**: Ambients Silent Kailh Low Profile Nocturnal Choc Switches.
- **Sockets**: Kailh Hotswap sockets for easy switch replacement.

#### Design Details

- **Layout**: Splayed split keyboard with a 3x5+3 layout.
  - **Thumb Cluster**: Three keys on each half.
  - **Outer Columns**: Split to reduce the distance to the keys.
- **Wireless**: Uses the XIAO BLE microcontroller for both halves and a dongle.
- **Battery**: Larger area for the battery to ensure longer usage time.

### Pipar Flake

The **Pipar Flake** is an 8+1 key wireless keypad with a rotary encoder and a screen. It includes:

- **Microcontroller**: SuperMini NRF52840.
- **Display**: Tiny OLED display.
- **Switches**: Ambients Silent Kailh Low Profile Nocturnal Choc Switches.
- **Sockets**: Kailh Hotswap sockets for easy switch replacement.

#### Design Details

- **Usage**: Intended as a tiny keypad or numpad.
  - **Current Use Case**: Control media player (e.g., Kodi).
- **Size**: Designed to be as small as possible while still being usable.
- **Rotary Encoder**: 
  - **Function**: Can control volume.
  - **Push Button**: Can be used to change layers.

## Schematic

Here is the schematic for the Pipar PCBs:

![Schematic](.extra/pipar_schematic.png)

## Layout

The layout of the Pipar PCBs is shown below:

![Layout](.extra/pipar_layout.png)

## Render

A render of the Pipar PCB design:

![Render](.extra/pipar_pcb.png)
