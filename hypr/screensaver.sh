#!/bin/bash
# Hyprland Screensaver Manager
# Provides various screensaver modes for Hyprland

SCREENSAVER_MODE="${1:-clock}"
LOCK_AFTER_SECONDS="${2:-300}"

case "$SCREENSAVER_MODE" in
    clock)
        # Clock screensaver using hyprlock
        hyprlock
        ;;

    matrix)
        # Matrix-style screensaver
        if command -v cmatrix &> /dev/null; then
            kitty --class=screensaver -e cmatrix -abs -C cyan &
            SCREENSAVER_PID=$!
            sleep $LOCK_AFTER_SECONDS
            kill $SCREENSAVER_PID 2>/dev/null
            hyprlock
        else
            echo "cmatrix not installed. Install with: sudo pacman -S cmatrix"
            hyprlock
        fi
        ;;

    pipes)
        # Pipes screensaver
        if command -v pipes.sh &> /dev/null; then
            kitty --class=screensaver -e pipes.sh &
            SCREENSAVER_PID=$!
            sleep $LOCK_AFTER_SECONDS
            kill $SCREENSAVER_PID 2>/dev/null
            hyprlock
        else
            echo "pipes.sh not installed. Install with: yay -S pipes.sh"
            hyprlock
        fi
        ;;

    starfield)
        # Starfield screensaver using asciiquarium
        if command -v asciiquarium &> /dev/null; then
            kitty --class=screensaver -e asciiquarium &
            SCREENSAVER_PID=$!
            sleep $LOCK_AFTER_SECONDS
            kill $SCREENSAVER_PID 2>/dev/null
            hyprlock
        else
            echo "asciiquarium not installed. Install with: yay -S asciiquarium"
            hyprlock
        fi
        ;;

    blank)
        # Just blank the screen and lock
        hyprctl dispatch dpms off
        sleep 1
        hyprlock
        hyprctl dispatch dpms on
        ;;

    video)
        # Play a video as screensaver (if mpv is installed)
        VIDEO_PATH="${3:-$HOME/Videos/screensaver.mp4}"
        if command -v mpv &> /dev/null && [ -f "$VIDEO_PATH" ]; then
            mpv --fs --loop --no-audio --no-osc --no-osd-bar "$VIDEO_PATH" &
            SCREENSAVER_PID=$!
            sleep $LOCK_AFTER_SECONDS
            kill $SCREENSAVER_PID 2>/dev/null
            hyprlock
        else
            echo "mpv not installed or video not found at $VIDEO_PATH"
            hyprlock
        fi
        ;;

    *)
        echo "Unknown screensaver mode: $SCREENSAVER_MODE"
        echo "Available modes: clock, matrix, pipes, starfield, blank, video"
        echo "Usage: $0 <mode> [lock_after_seconds] [video_path]"
        exit 1
        ;;
esac
