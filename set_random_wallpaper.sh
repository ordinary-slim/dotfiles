#!/bin/bash

# Directory containing wallpapers
directory="$HOME/wallpapers"

monitors=$(hyprctl monitors | awk '/Monitor/{print $2}')

# Check if directory exists and contains images
if [ -d "$directory" ]; then
    # Find all supported image files (case-insensitive)
    mapfile -t images < <(find "$directory" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \))

    # Ensure there is at least one image
    if [ "${#images[@]}" -eq 0 ]; then
        echo "No images found in $directory"
        exit 1
    fi

    hyprctl hyprpaper unload all
    monitor_index=0
    for monitor in $monitors; do
      ((monitor_index++))
      # Better randomness: use $RANDOM with a nanosecond seed for variety
      seed=$(date +%N)$monitor_index
      # force base-10 for seed to avoid octal parsing
      random_index=$(( (RANDOM * (10#$seed)) % ${#images[@]} ))
      random_background="${images[$random_index]}"

      # Apply wallpaper
      hyprctl hyprpaper preload "$random_background"
      hyprctl hyprpaper wallpaper $monitor, "$random_background"

      echo "Set wallpaper: $random_background in monitor: $monitor"
    done
fi
