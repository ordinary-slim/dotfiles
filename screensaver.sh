#!/usr/bin/env bash

exit_screensaver() {
  pkill -f pipes.sh
  pkill -f "ghostty --class=Screensaver"
}

is_running() {
  if pgrep -f pipes.sh >/dev/null; then
    return 0
  else
    return 1
  fi
}

loop_screensaver() {
  trap exit_screensaver SIGINT SIGTERM SIGHUP SIGQUIT
  pipes.sh </dev/null &
  while true; do
  # -r: raw, -s: silent (no echo), -n1: 1 char, -t 0.1: small timeout
  if read -n 1 -t 3; then
    exit_screensaver
  fi
done
}

launch_screensaver() {
  if is_running; then
    exit 0
  fi

  # TODO: Using both jq and awk
  monitors=$(hyprctl monitors | awk '/Monitor/{print $2}')

  focused=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')

  for monitor in $monitors; do
    # Focus the monitor so the new window opens there
    hyprctl dispatch focusmonitor "$monitor"
    # Launch Ghostty running pipes.sh
    hyprctl dispatch exec 'ghostty --class=Screensaver --fullscreen --command="$HOME/.config/screensaver.sh loop_screensaver"'
  done

  hyprctl dispatch focusmonitor $focused
}

$@
