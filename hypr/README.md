# Hyprland Configuration

This directory contains configuration files for Hyprland and its ecosystem on Arch Linux.

## Files

### Core Configuration
- `hyprland.conf` - Main Hyprland configuration
- `hypridle.conf` - Idle management configuration
- `hyprlock.conf` - Lock screen configuration

### Screensaver & Wallpapers
- `hyprlock-screensaver.conf` - Screensaver-style lock screen
- `hypridle-screensaver.conf` - Idle management with screensaver mode
- `screensaver.sh` - Multi-mode screensaver launcher script
- `start-animated-wallpaper.sh` - Animated wallpaper startup script
- `mpvpaper.conf` - Animated wallpaper configuration notes
- `SCREENSAVER.md` - Comprehensive screensaver documentation

## Installation

### Arch Linux

Run the provided installation script from the dotfiles root directory:

```bash
cd ~/.dotfiles
./install-hyprland-arch.sh
```

This script will:
- Install Hyprland, Hypridle, and Hyprlock
- Install essential dependencies (waybar, wofi, kitty, etc.)
- Set up configuration files
- Create necessary directories

### Manual Installation

If you prefer to install manually:

```bash
# Install packages
sudo pacman -S hyprland hypridle hyprlock xdg-desktop-portal-hyprland \
    kitty waybar wofi dunst hyprpaper grim slurp wl-clipboard \
    brightnessctl pipewire wireplumber pavucontrol networkmanager \
    ttf-jetbrains-mono-nerd

# Copy configs
mkdir -p ~/.config/hypr
cp hypr/* ~/.config/hypr/
```

## Configuration Overview

### hyprland.conf

Main Hyprland configuration featuring:
- **Monitor setup** - Auto-detection with preferred resolution
- **Aesthetics** - Catppuccin Mocha color scheme, blur effects, rounded corners
- **Keybindings** - Vim-style navigation with SUPER key as modifier
- **Workspaces** - 10 workspaces with quick switching
- **Animations** - Smooth window animations
- **Window rules** - Floating windows for specific applications

### hypridle.conf

Idle management with progressive timeouts:
- **5 minutes** - Dim screen to 10% brightness
- **10 minutes** - Lock screen
- **15 minutes** - Turn off display
- **30 minutes** - Suspend system

### hyprlock.conf

Lock screen configuration with:
- Blurred screenshot background
- Password input field
- Time and date display
- Battery indicator
- Keyboard layout indicator
- User greeting

## Key Bindings

### Applications
- `SUPER + RETURN` - Terminal (kitty)
- `SUPER + D` - Application launcher (wofi)
- `SUPER + E` - File manager (thunar)
- `SUPER + L` - Lock screen
- `SUPER + Q` - Close window
- `SUPER + M` - Exit Hyprland

### Window Management
- `SUPER + h/j/k/l` or Arrow keys - Move focus
- `SUPER + SHIFT + h/j/k/l` or Arrow keys - Move window
- `SUPER + F` - Fullscreen
- `SUPER + V` - Toggle floating
- `SUPER + R` - Enter resize mode (use arrow keys or hjkl, ESC to exit)

### Workspaces
- `SUPER + 1-9,0` - Switch to workspace
- `SUPER + SHIFT + 1-9,0` - Move window to workspace
- `SUPER + Mouse Wheel` - Scroll through workspaces

### Screenshots
- `SUPER + S` - Screenshot area to clipboard
- `SUPER + SHIFT + S` - Screenshot area to file

### Media Controls
- `XF86AudioRaiseVolume/LowerVolume` - Volume up/down
- `XF86AudioMute` - Mute toggle
- `XF86MonBrightnessUp/Down` - Brightness up/down

## Customization

### Monitors

Edit `hyprland.conf` to configure your monitors:

```conf
# Example for a laptop with external monitor
monitor=eDP-1,1920x1080@60,0x0,1
monitor=HDMI-A-1,2560x1440@144,1920x0,1
```

Find your monitor names with: `hyprctl monitors`

### Wallpaper

1. Add your wallpaper to `~/Pictures/Wallpapers/`
2. Edit `~/.config/hypr/hyprpaper.conf`:

```conf
preload = ~/Pictures/Wallpapers/your-wallpaper.jpg
wallpaper = ,~/Pictures/Wallpapers/your-wallpaper.jpg
```

### Theme Colors

The configuration uses Catppuccin Mocha color scheme. To change:
- Edit color values in `hyprland.conf` (search for `col.active_border`)
- Edit colors in `hyprlock.conf` for lock screen theme

### Keyboard Layout

Change in `hyprland.conf`:

```conf
input {
    kb_layout = us,de  # Multiple layouts
    kb_options = grp:alt_shift_toggle  # Switch with Alt+Shift
}
```

## Troubleshooting

### Screen not locking
- Ensure hypridle is running: `pidof hypridle`
- Check logs: `journalctl --user -u hypridle`

### No wallpaper showing
- Check hyprpaper service: `pidof hyprpaper`
- Verify wallpaper path in `~/.config/hypr/hyprpaper.conf`

### Applications not launching
- Verify application is installed: `which kitty`
- Change application variables in `hyprland.conf`

### Graphics issues
- Update graphics drivers
- Check Hyprland logs: `~/.hyprland/hyprland.log`

## Dependencies

### Required
- hyprland - Window manager
- hypridle - Idle management
- hyprlock - Lock screen
- kitty - Terminal emulator
- wofi - Application launcher
- waybar - Status bar

### Recommended
- dunst - Notifications
- hyprpaper - Wallpaper manager
- grim, slurp - Screenshots
- brightnessctl - Brightness control
- pavucontrol - Audio control
- network-manager-applet - Network management

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)

## License

These configuration files are free to use and modify as needed.
