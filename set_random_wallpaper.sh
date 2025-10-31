#!/bin/bash

# Directory containing wallpapers
directory="$HOME/wallpapers"

# Detect the active monitor
monitor=$(hyprctl monitors | awk '/Monitor/{print $2}')

# Check if directory exists and contains images
if [ -d "$directory" ]; then
    # Find all supported image files (case-insensitive)
    mapfile -t images < <(find "$directory" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \))

    # Ensure there is at least one image
    if [ "${#images[@]}" -eq 0 ]; then
        echo "No images found in $directory"
        exit 1
    fi

    # Better randomness: use $RANDOM with a nanosecond seed for variety
    seed=$(date +%N)
    # force base-10 for seed to avoid octal parsing
    random_index=$(( (RANDOM * (10#$seed)) % ${#images[@]} ))
    random_background="${images[$random_index]}"

    sleep 0.05

    # Apply wallpaper
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$random_background"
    hyprctl hyprpaper wallpaper "$monitor, $random_background"

    echo "Set wallpaper: $random_background"
fi
