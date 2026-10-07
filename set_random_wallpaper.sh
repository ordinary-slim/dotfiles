#!/bin/bash

directory="$HOME/wallpapers"

if [ ! -d "$directory" ]; then
    echo "Wallpaper directory does not exist: $directory" >&2
    exit 1
fi

mapfile -d '' -t images < <(find "$directory" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \) -print0)
if [ "${#images[@]}" -eq 0 ]; then
    echo "No images found in $directory" >&2
    exit 1
fi

if ! monitor_output=$(hyprctl monitors); then
    echo "Failed to discover monitors" >&2
    exit 1
fi
mapfile -t monitors < <(awk '/^Monitor / {print $2}' <<< "$monitor_output")

# Wait for the running daemon's IPC before applying any wallpapers.
ready=false
for ((attempt = 1; attempt <= 50; attempt++)); do
    if error=$(hyprctl hyprpaper listactive 2>&1); then
        ready=true
        break
    fi
    if ((attempt < 50)); then
        sleep 0.1
    fi
done
if [ "$ready" = false ]; then
    echo "Timed out waiting for hyprpaper readiness: $error" >&2
    exit 1
fi

status=0

random_index=$((RANDOM % ${#images[@]}))
random_wallpaper="${images[$random_index]}"

for monitor in "${monitors[@]}"; do
    if error=$(hyprctl hyprpaper wallpaper "$monitor,$random_wallpaper" 2>&1); then
        echo "Set wallpaper: $random_wallpaper in monitor: $monitor"
    else
        echo "Failed to set wallpaper on $monitor: $error" >&2
        status=1
    fi
done

exit "$status"
