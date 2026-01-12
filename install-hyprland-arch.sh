#!/bin/bash
# Arch Linux Hyprland Installation Script

set -e  # Exit on error

echo "======================================"
echo "Installing Hyprland and Dependencies"
echo "======================================"

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install Hyprland and essential packages
echo "Installing Hyprland..."
sudo pacman -S --noconfirm hyprland hypridle hyprlock \
    xdg-desktop-portal-hyprland \
    qt5-wayland qt6-wayland \
    polkit-kde-agent

# Install terminal emulator
echo "Installing terminal and shell..."
sudo pacman -S --noconfirm kitty zsh

# Install file manager
echo "Installing file manager..."
sudo pacman -S --noconfirm thunar thunar-archive-plugin \
    thunar-media-tags-plugin thunar-volman \
    gvfs gvfs-mtp

# Install application launcher and bar
echo "Installing wofi and waybar..."
sudo pacman -S --noconfirm wofi waybar

# Install notification daemon
echo "Installing notification daemon..."
sudo pacman -S --noconfirm dunst

# Install wallpaper manager
echo "Installing hyprpaper..."
sudo pacman -S --noconfirm hyprpaper

# Install screenshot tools
echo "Installing screenshot tools..."
sudo pacman -S --noconfirm grim slurp wl-clipboard

# Install brightness and audio control
echo "Installing brightness and audio controls..."
sudo pacman -S --noconfirm brightnessctl \
    wireplumber pipewire pipewire-pulse pipewire-alsa \
    pavucontrol

# Install network manager
echo "Installing network manager..."
sudo pacman -S --noconfirm networkmanager nm-connection-editor \
    network-manager-applet

# Install fonts
echo "Installing fonts..."
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd \
    ttf-font-awesome noto-fonts noto-fonts-emoji \
    ttf-dejavu ttf-liberation

# Install additional utilities
echo "Installing additional utilities..."
sudo pacman -S --noconfirm jq fzf ripgrep fd bat eza

# Install AUR helper (yay) if not present
if ! command -v yay &> /dev/null; then
    echo "Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# Optional: Install Rofi (Wayland version) as alternative launcher
echo "======================================"
echo "App Launcher Selection"
echo "======================================"
echo "Wofi is installed by default. You can also install Rofi for more features."
read -p "Install Rofi (Wayland) as well? [y/N]: " install_rofi
if [[ $install_rofi =~ ^[Yy]$ ]]; then
    echo "Installing Rofi (Wayland)..."
    yay -S --noconfirm rofi-lbonn-wayland-git
fi

# Optional: Install screensaver packages
echo ""
echo "======================================"
echo "Screensaver Options"
echo "======================================"
echo "Hyprlock provides a beautiful lock screen with clock screensaver."
echo "Additional screensaver options available:"
echo "  • Animated wallpapers (mpvpaper) - Video wallpapers"
echo "  • Terminal screensavers (cmatrix, pipes.sh, etc.)"
echo ""
read -p "Install animated wallpaper support (mpvpaper)? [y/N]: " install_mpvpaper
if [[ $install_mpvpaper =~ ^[Yy]$ ]]; then
    echo "Installing mpvpaper..."
    yay -S --noconfirm mpvpaper
fi

read -p "Install terminal screensavers (cmatrix, pipes.sh)? [y/N]: " install_term_screensavers
if [[ $install_term_screensavers =~ ^[Yy]$ ]]; then
    echo "Installing terminal screensavers..."
    sudo pacman -S --noconfirm cmatrix
    yay -S --noconfirm pipes.sh
fi

echo "======================================"
echo "Setting up configuration files"
echo "======================================"

# Create necessary directories
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi
mkdir -p ~/.config/dunst
mkdir -p ~/.config/kitty
mkdir -p ~/Pictures/Screenshots

# Copy Hyprland configs
echo "Copying Hyprland configuration files..."
cp -r hypr/* ~/.config/hypr/

# Make screensaver scripts executable
chmod +x ~/.config/hypr/screensaver.sh 2>/dev/null || true
chmod +x ~/.config/hypr/start-animated-wallpaper.sh 2>/dev/null || true

# Create Videos/Wallpapers directory for animated wallpapers
mkdir -p ~/Videos/Wallpapers

# Copy Wofi configs
echo "Copying Wofi configuration files..."
cp -r wofi/* ~/.config/wofi/

# Copy Rofi configs if Rofi was installed
if command -v rofi &> /dev/null; then
    echo "Copying Rofi configuration files..."
    mkdir -p ~/.config/rofi
    cp -r rofi/* ~/.config/rofi/
fi

# Enable NetworkManager service
echo "Enabling NetworkManager..."
sudo systemctl enable --now NetworkManager

# Create a basic hyprpaper config if it doesn't exist
if [ ! -f ~/.config/hypr/hyprpaper.conf ]; then
    echo "Creating basic hyprpaper config..."
    cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/Pictures/Wallpapers/wallpaper.jpg
wallpaper = ,~/Pictures/Wallpapers/wallpaper.jpg
splash = false
EOF
fi

# Create wallpaper directory
mkdir -p ~/Pictures/Wallpapers

# Create a basic waybar config if it doesn't exist
if [ ! -f ~/.config/waybar/config ]; then
    echo "Creating basic waybar config..."
    cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery", "tray"],

    "hyprland/workspaces": {
        "disable-scroll": false,
        "all-outputs": true,
        "format": "{name}",
        "on-click": "activate"
    },

    "hyprland/window": {
        "max-length": 50
    },

    "clock": {
        "format": "{:%H:%M  %Y-%m-%d}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },

    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },

    "network": {
        "format-wifi": " {essid}",
        "format-ethernet": " Connected",
        "format-disconnected": "⚠ Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}"
    },

    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": " Muted",
        "format-icons": {
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },

    "tray": {
        "spacing": 10
    }
}
EOF

    cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrains Mono Nerd Font";
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background: rgba(30, 30, 46, 0.9);
    color: #cdd6f4;
}

#workspaces button {
    padding: 0 5px;
    color: #cdd6f4;
    background: transparent;
}

#workspaces button.active {
    background: #89b4fa;
    color: #1e1e2e;
}

#workspaces button:hover {
    background: #585b70;
}

#clock, #battery, #network, #pulseaudio, #tray, #window {
    padding: 0 10px;
}

#battery.charging {
    color: #a6e3a1;
}

#battery.warning:not(.charging) {
    color: #f9e2af;
}

#battery.critical:not(.charging) {
    color: #f38ba8;
}
EOF
fi

# Create basic kitty config if it doesn't exist
if [ ! -f ~/.config/kitty/kitty.conf ]; then
    echo "Creating basic kitty config..."
    mkdir -p ~/.config/kitty
    cat > ~/.config/kitty/kitty.conf << 'EOF'
# Kitty Configuration

# Font
font_family JetBrains Mono Nerd Font
font_size 11.0

# Theme - Catppuccin Mocha
foreground #cdd6f4
background #1e1e2e
background_opacity 0.95

# Cursor
cursor #f5e0dc
cursor_text_color #1e1e2e

# Colors
color0 #45475a
color1 #f38ba8
color2 #a6e3a1
color3 #f9e2af
color4 #89b4fa
color5 #f5c2e7
color6 #94e2d5
color7 #bac2de

color8 #585b70
color9 #f38ba8
color10 #a6e3a1
color11 #f9e2af
color12 #89b4fa
color13 #f5c2e7
color14 #94e2d5
color15 #a6adc8

# Window
window_padding_width 10
confirm_os_window_close 0
EOF
fi

echo "======================================"
echo "Installation Complete!"
echo "======================================"
echo ""
echo "To start Hyprland:"
echo "  1. Reboot your system"
echo "  2. At the login screen, select Hyprland"
echo "  Or run: Hyprland"
echo ""
echo "Key bindings (SUPER = Windows/Command key):"
echo "  SUPER + RETURN    - Open terminal (Kitty)"
echo "  SUPER + D         - Application launcher (Wofi)"
echo "  SUPER + Q         - Close window"
echo "  SUPER + L         - Lock screen (Hyprlock)"
echo "  SUPER + M         - Exit Hyprland"
echo "  SUPER + E         - File manager (Thunar)"
echo "  SUPER + S         - Screenshot (select area)"
echo ""
echo "App Launchers installed:"
echo "  • Wofi - Beautiful, lightweight launcher (default)"
if command -v rofi &> /dev/null; then
    echo "  • Rofi - Feature-rich launcher with window switcher"
    echo "    To use Rofi, edit ~/.config/hypr/hyprland.conf"
    echo "    Change: \$menu = rofi -show drun"
fi
echo ""
echo "Screensaver & Lock Screen:"
echo "  • Hyprlock - Beautiful lock screen with clock (default)"
echo "  • Hypridle - Automatic lock after idle time"
if command -v mpvpaper &> /dev/null; then
    echo "  • MPVPaper - Animated video wallpapers"
    echo "    Add videos to ~/Videos/Wallpapers/ and run:"
    echo "    ~/.config/hypr/start-animated-wallpaper.sh"
fi
if command -v cmatrix &> /dev/null; then
    echo "  • Terminal screensavers - Matrix, pipes, etc."
    echo "    Usage: ~/.config/hypr/screensaver.sh <mode>"
    echo "    Modes: clock, matrix, pipes, starfield, blank, video"
fi
echo ""
echo "Don't forget to:"
echo "  1. Add a wallpaper to ~/Pictures/Wallpapers/wallpaper.jpg"
echo "  2. Configure your monitors in ~/.config/hypr/hyprland.conf"
echo "  3. Customize colors and themes in each config directory"
echo "  4. Check out the README files in hypr/, wofi/, and rofi/ directories"
if command -v mpvpaper &> /dev/null; then
    echo "  5. Add video wallpapers to ~/Videos/Wallpapers/ (optional)"
fi
