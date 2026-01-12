# Wofi Configuration

Beautiful application launcher configuration for Wofi with Catppuccin Mocha theme.

## Features

- Centered window with 600x400 dimensions
- Blurred transparent background
- Rounded corners and modern borders
- Icon support with 32px icons
- Smooth hover and selection animations
- Color-matched with Hyprland theme

## Installation

The installation script automatically sets this up, but for manual installation:

```bash
mkdir -p ~/.config/wofi
cp wofi/* ~/.config/wofi/
```

## Usage

Launch wofi with:
```bash
wofi --show drun
```

In Hyprland, it's bound to `SUPER + D` by default.

## Customization

### Change Size

Edit `config`:
```
width=800
height=500
```

### Change Position

Edit `config`:
```
location=top        # Options: center, top, bottom, left, right
y=100              # Y offset from location
x=0                # X offset from location
```

### Modify Colors

Edit `style.css` - main colors to change:
- `#89b4fa` - Blue accent (border, selected)
- `#1e1e2e` - Background
- `#cdd6f4` - Text color
- `#313244` - Hover background

## Screenshots

The launcher features:
- Gradient border in blue/purple
- Semi-transparent dark background
- Large, clear search box
- Icon + text for each application
- Gradient highlight on selection
- Smooth animations
