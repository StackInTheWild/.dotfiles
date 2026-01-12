# Rofi Configuration

Beautiful application launcher configuration for Rofi (Wayland) with Catppuccin Mocha theme.

## Features

- Clean, modern design with rounded corners
- Support for multiple modes (Apps, Run, Windows)
- Sidebar mode switcher
- Icon support with 32px icons
- Smooth transitions
- Wayland native support
- Color-matched with Hyprland theme

## Installation

### Prerequisites

Rofi requires the Wayland fork for Hyprland:

```bash
yay -S rofi-lbonn-wayland-git
```

### Setup

The installation script can set this up, or manually:

```bash
mkdir -p ~/.config/rofi
cp rofi/config.rasi ~/.config/rofi/
```

### Using Rofi Instead of Wofi

To use Rofi as your app launcher in Hyprland, edit `~/.config/hypr/hyprland.conf`:

```conf
$menu = rofi -show drun
```

## Usage

Launch rofi with:
```bash
rofi -show drun      # Applications
rofi -show run       # Run command
rofi -show window    # Window switcher
```

In Hyprland, it's bound to `SUPER + D` when configured.

## Features by Mode

### Apps Mode (drun)
- Search installed applications
- Launch applications with Enter
- Shows application icons and descriptions

### Run Mode
- Execute any command
- Command history
- Tab completion

### Windows Mode
- Switch between open windows
- Search by window title
- Quick workspace switching

## Customization

### Change Size

Edit `config.rasi`:
```rasi
* {
    width: 800;
}

window {
    height: 500px;
}
```

### Change Lines Shown

Edit `config.rasi`:
```rasi
listview {
    lines: 10;  // Number of items to show
}
```

### Modify Colors

In `config.rasi`, update the color definitions:
```rasi
* {
    bg-col: #1e1e2e;        // Background
    border-col: #89b4fa;    // Border
    blue: #89b4fa;          // Accent
    fg-col: #cdd6f4;        // Text
}
```

### Change Font

Edit `config.rasi`:
```rasi
* {
    font: "JetBrains Mono Nerd Font 14";
}
```

## Comparison: Rofi vs Wofi

**Rofi:**
- More features (window switcher, run mode)
- Highly customizable
- More configuration options
- Larger community and themes
- Slightly more resource usage

**Wofi:**
- Simpler and lighter
- Native Wayland design
- Faster startup
- Minimal configuration
- Good for basic launcher needs

Choose based on your needs - both are excellent launchers!
