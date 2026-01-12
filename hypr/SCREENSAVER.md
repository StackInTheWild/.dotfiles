# Screensaver Configuration for Hyprland

Complete screensaver and animated wallpaper setup for Hyprland on Arch Linux.

## Overview

This configuration provides multiple screensaver options:

1. **Hyprlock** - Beautiful lock screen with clock (default)
2. **Animated Wallpapers** - Video backgrounds using mpvpaper
3. **Terminal Screensavers** - Classic screensavers (matrix, pipes, etc.)
4. **Custom Screensaver Modes** - Scriptable screensaver options

## Configuration Files

- `hyprlock.conf` - Standard lock screen (default)
- `hyprlock-screensaver.conf` - Minimalist screensaver-style lock screen
- `hypridle.conf` - Standard idle management
- `hypridle-screensaver.conf` - Idle management with screensaver mode
- `screensaver.sh` - Script to launch different screensaver modes
- `start-animated-wallpaper.sh` - Script to start video wallpapers
- `mpvpaper.conf` - Configuration notes for animated wallpapers

## Quick Start

### Default Setup (Already Working)

Your system already has:
- Hyprlock (beautiful lock screen with clock)
- Hypridle (auto-lock after 10 minutes idle)
- Press `SUPER + L` to lock screen manually

No additional setup needed for basic functionality!

### Enable Screensaver Mode

For a more minimal screensaver-style lock screen:

```bash
# Use screensaver-style lock screen
cp ~/.config/hypr/hypridle-screensaver.conf ~/.config/hypr/hypridle.conf

# Restart hypridle
killall hypridle
hypridle &
```

This provides:
- Large animated clock
- Minimal interface
- Subtle system info (battery, uptime)
- Weather display (optional)

## Animated Wallpapers

### Setup MPVPaper

1. Install mpvpaper:
```bash
yay -S mpvpaper
```

2. Add video files to `~/Videos/Wallpapers/`

3. Set default wallpaper:
```bash
ln -s ~/Videos/Wallpapers/your-video.mp4 ~/Videos/Wallpapers/default.mp4
```

4. Start animated wallpaper:
```bash
~/.config/hypr/start-animated-wallpaper.sh
```

5. Auto-start on login by adding to `hyprland.conf`:
```conf
exec-once = ~/.config/hypr/start-animated-wallpaper.sh
```

### Finding Wallpaper Videos

**Free Video Sources:**
- [Pexels Videos](https://www.pexels.com/videos/) - Free stock videos
- [Pixabay Videos](https://pixabay.com/videos/) - Free animations
- [Mixkit](https://mixkit.co/free-stock-video/) - Free video backgrounds

**YouTube Videos:**
```bash
# Install yt-dlp
sudo pacman -S yt-dlp

# Download video
yt-dlp -f 'bestvideo[ext=mp4][height<=1080]' -o ~/Videos/Wallpapers/video.mp4 'URL'
```

**Recommended Searches:**
- "Lofi animation loop"
- "Cyberpunk city loop"
- "Nature scenery 4k"
- "Abstract background loop"
- "Firewatch animated wallpaper"

### Optimize Videos for Wallpapers

Convert/optimize videos with ffmpeg:

```bash
# Reduce file size and optimize for looping
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -preset medium \
       -vf "scale=1920:1080" -an output.mp4

# Create seamless loop
ffmpeg -i input.mp4 -filter_complex \
       "[0:v]trim=0:10,setpts=PTS-STARTPTS[v0];
        [0:v]trim=10:20,setpts=PTS-STARTPTS,reverse[v1];
        [v0][v1]concat=n=2:v=1[out]" \
       -map "[out]" seamless-loop.mp4
```

## Terminal Screensavers

### Install Terminal Screensavers

```bash
# Install packages
sudo pacman -S cmatrix
yay -S pipes.sh asciiquarium
```

### Usage

```bash
# Launch different screensaver modes
~/.config/hypr/screensaver.sh clock      # Default lock screen
~/.config/hypr/screensaver.sh matrix     # Matrix falling text
~/.config/hypr/screensaver.sh pipes      # Colorful pipes
~/.config/hypr/screensaver.sh starfield  # Aquarium animation
~/.config/hypr/screensaver.sh blank      # Blank screen
~/.config/hypr/screensaver.sh video      # Video screensaver
```

### Set Default Screensaver Mode

Edit `hypridle-screensaver.conf`:

```conf
general {
    # Change clock to your preferred mode
    lock_cmd = pidof hyprlock || ~/.config/hypr/screensaver.sh matrix
}
```

Then reload:
```bash
cp ~/.config/hypr/hypridle-screensaver.conf ~/.config/hypr/hypridle.conf
killall hypridle && hypridle &
```

## Screensaver Modes Explained

### Clock (Default)
Beautiful lock screen with:
- Large animated clock
- Date display
- User greeting
- Battery indicator
- System information

### Matrix
Classic Matrix-style falling characters:
- Cyan colored text
- Fullscreen terminal
- Locks after 5 minutes

### Pipes
Colorful animated pipes:
- Retro screensaver aesthetic
- Colorful flowing pipes
- Locks after 5 minutes

### Starfield
Aquarium/underwater theme:
- ASCII art animation
- Calming aesthetic
- Locks after 5 minutes

### Blank
Minimal power-saving mode:
- Turns off display
- Immediate lock
- Maximum battery saving

### Video
Play custom video as screensaver:
```bash
~/.config/hypr/screensaver.sh video 300 ~/Videos/screensaver.mp4
```
- Loops video file
- Locks after specified seconds (default 300)
- Fullscreen playback

## Customization

### Change Lock Timeout

Edit `hypridle.conf` or `hypridle-screensaver.conf`:

```conf
# Lock screen after 5 minutes
listener {
    timeout = 300  # Change this value (seconds)
    on-timeout = loginctl lock-session
}
```

### Customize Screensaver Lock Screen

Edit `hyprlock-screensaver.conf`:

**Change clock format:**
```conf
label {
    text = cmd[update:1000] echo "<b>$(date +"%I:%M:%S %p")</b>"  # 12-hour format
    # or
    text = cmd[update:1000] echo "<b>$(date +"%H:%M:%S")</b>"     # 24-hour format
}
```

**Change colors:**
```conf
label {
    color = rgba(137, 180, 250, 0.8)  # Blue
    # Common Catppuccin Mocha colors:
    # rgba(137, 180, 250, 0.8) - Blue
    # rgba(166, 227, 161, 0.8) - Green
    # rgba(243, 139, 168, 0.8) - Pink
    # rgba(249, 226, 175, 0.8) - Yellow
}
```

**Add custom information:**
```conf
# Example: Show currently playing music
label {
    monitor =
    text = cmd[update:1000] playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo ""
    color = rgba(205, 214, 244, 0.6)
    font_size = 16
    position = 0, -300
    halign = center
    valign = center
}
```

### Disable Weather Display

Edit `hyprlock-screensaver.conf` and remove or comment out:

```conf
# Weather (optional - requires wttr.in)
# label {
#     text = cmd[update:3600000] curl -s 'wttr.in/?format=%c+%t' 2>/dev/null || echo ""
#     ...
# }
```

### Create Custom Screensaver Mode

Add to `screensaver.sh`:

```bash
custom)
    # Your custom screensaver command
    kitty --class=screensaver -e your-command &
    SCREENSAVER_PID=$!
    sleep $LOCK_AFTER_SECONDS
    kill $SCREENSAVER_PID 2>/dev/null
    hyprlock
    ;;
```

## Advanced Configuration

### Multiple Monitor Setup

For animated wallpapers on specific monitors:

```bash
# Use specific monitor
mpvpaper -o "loop no-audio" eDP-1 ~/Videos/Wallpapers/laptop.mp4 &
mpvpaper -o "loop no-audio" HDMI-A-1 ~/Videos/Wallpapers/external.mp4 &

# Or use '*' for all monitors
mpvpaper -o "loop no-audio" '*' ~/Videos/Wallpapers/default.mp4 &
```

### Power Saving Options

Edit `hypridle-screensaver.conf`:

```conf
# More aggressive power saving
listener {
    timeout = 300   # 5 minutes - dim screen
    on-timeout = brightnessctl -s set 5%  # Dimmer
}

listener {
    timeout = 600   # 10 minutes - suspend
    on-timeout = systemctl suspend
}
```

### Prevent Screen Lock During Media Playback

Install `playerctl` and modify `hypridle.conf`:

```bash
sudo pacman -S playerctl
```

Hypridle automatically respects DBUS inhibit requests from media players.

### Manual Inhibit

Temporarily prevent screen lock:

```bash
# Inhibit sleep/lock
systemd-inhibit --what=idle --who=YourName --why="Watching video" sleep infinity

# Or use caffeine-ng
yay -S caffeine-ng
caffeine
```

## Troubleshooting

### Screensaver not starting
```bash
# Check hypridle is running
pidof hypridle || hypridle &

# Check hypridle logs
journalctl --user -u hypridle -f
```

### MPVPaper not working
```bash
# Kill existing instances
killall mpvpaper

# Test manually
mpvpaper -o "loop no-audio" eDP-1 ~/Videos/Wallpapers/test.mp4

# Check video file is valid
mpv ~/Videos/Wallpapers/test.mp4
```

### Lock screen not showing
```bash
# Test hyprlock directly
hyprlock

# Test screensaver config
hyprlock -c ~/.config/hypr/hyprlock-screensaver.conf

# Check logs
journalctl --user -xe | grep hyprlock
```

### High CPU usage with animated wallpaper
```bash
# Limit FPS in mpvpaper command
mpvpaper -o "loop no-audio fps=30" '*' ~/Videos/Wallpapers/video.mp4

# Or use lower resolution video
ffmpeg -i input.mp4 -vf scale=1920:1080 -c:v libx264 -crf 28 output.mp4
```

### Scripts not executable
```bash
chmod +x ~/.config/hypr/screensaver.sh
chmod +x ~/.config/hypr/start-animated-wallpaper.sh
```

## Tips & Best Practices

1. **Video Size**: Keep wallpaper videos under 100MB for best performance
2. **Format**: Use MP4 with H.264 codec for maximum compatibility
3. **Resolution**: Match or slightly exceed your screen resolution
4. **Looping**: Create seamless loops for best visual experience
5. **Battery**: Disable animated wallpapers on battery power
6. **Multiple Monitors**: Use different videos per monitor for variety

## Battery-Conscious Setup

For laptops, you might want different behavior on battery:

```bash
# Add to hyprland.conf or a startup script
#!/bin/bash
if [[ $(cat /sys/class/power_supply/BAT*/status 2>/dev/null) == "Discharging" ]]; then
    # On battery: use static wallpaper
    killall mpvpaper
    hyprpaper &
else
    # On AC: use animated wallpaper
    ~/.config/hypr/start-animated-wallpaper.sh
fi
```

## Resources

- [Hyprlock Documentation](https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/)
- [Hypridle Documentation](https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/)
- [MPVPaper GitHub](https://github.com/GhostNaN/mpvpaper)
- [Free Video Wallpapers](https://www.pexels.com/videos/)
- [Catppuccin Colors](https://github.com/catppuccin/catppuccin)

## Example Videos to Try

Search for these on YouTube (use yt-dlp to download):
- "lofi girl animation loop"
- "cyberpunk city rain loop"
- "forest nature 4k loop"
- "space nebula 4k"
- "geometric abstract loop"
- "firewatch style animation"
- "vaporwave aesthetic loop"

Enjoy your beautiful Hyprland screensavers! 🎨✨
