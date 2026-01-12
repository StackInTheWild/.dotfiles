#!/bin/bash
# Start animated wallpaper with mpvpaper

WALLPAPER_DIR="$HOME/Videos/Wallpapers"
DEFAULT_WALLPAPER="$WALLPAPER_DIR/default.mp4"

# Kill existing mpvpaper instances
killall mpvpaper 2>/dev/null
sleep 0.5

# Check if mpvpaper is installed
if ! command -v mpvpaper &> /dev/null; then
    echo "mpvpaper not installed. Install with: yay -S mpvpaper"
    # Fallback to hyprpaper
    hyprpaper &
    exit 0
fi

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Use custom wallpaper if it exists, otherwise use first video found
if [ -f "$DEFAULT_WALLPAPER" ]; then
    WALLPAPER="$DEFAULT_WALLPAPER"
else
    # Find first video file in wallpaper directory
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.mp4" -o -name "*.webm" -o -name "*.mkv" \) | head -n 1)
fi

# If no video wallpaper found, fallback to hyprpaper
if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    echo "No video wallpaper found in $WALLPAPER_DIR"
    echo "Using hyprpaper instead..."
    hyprpaper &
    exit 0
fi

# Start mpvpaper with the wallpaper
echo "Starting animated wallpaper: $WALLPAPER"
mpvpaper -o "loop no-audio hwdec=auto" '*' "$WALLPAPER" &

# Optional: Add fps limit to save resources
# mpvpaper -o "loop no-audio hwdec=auto fps=30" '*' "$WALLPAPER" &
