#!/usr/bin/env bash
# Toggle region recording: first call selects a region and records, second call stops.
# The saved file is copied to the clipboard as a file URI (pasteable in browsers, chat apps, file managers).

pkill -INT -x wf-recorder && exit 0

geometry=$(slurp) || exit 1
file="$HOME/Videos/rec-$(date +%F_%H-%M-%S).mp4"

notify-send -t 2000 "Recording started"
wf-recorder -g "$geometry" -f "$file" || exit 1

wl-copy --type text/uri-list "file://$file"
notify-send -t 5000 "Recording copied to clipboard" "$file"
