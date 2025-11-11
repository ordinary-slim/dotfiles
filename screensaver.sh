#!/usr/bin/env bash

export SCREENSAVER="tte"
export LOGO=$(cat $HOME/.config/flare.txt)

exit_screensaver() {
  hyprctl keyword cursor:invisible false &>/dev/null
  pkill -9 -f ${SCREENSAVER}
  pkill -f "ghostty --class=Screensaver"
  exit 0
}

is_running() {
  if pgrep -f "ghostty --class=Screensaver"; then
    return 0
  else
    return 1
  fi
}

loop_screensaver() {

  stty -echo -icanon time 0 min 0 </dev/tty

  trap exit_screensaver SIGINT SIGTERM SIGHUP SIGQUIT

  hyprctl keyword cursor:invisible true &>/dev/null

  while true; do
    effect=$(tte 2>&1 | grep -oP '{\K[^}]+' | tr ',' ' ' | tr ' ' '\n' | sed -n '/^beams$/,$p' | sort -u | shuf -n1)
    echo "$LOGO" | tte --frame-rate 240 --canvas-width 0 --canvas-height $(($(tput lines) - 2)) --anchor-canvas c --anchor-text c "$effect" &
    while pgrep -x tte >/dev/null; do
      if read -rs -n 1 -t 3; then
        exit_screensaver
      fi
    done
  done
}

launch_screensaver() {
  if is_running; then
    exit 0
  fi

  monitors=$(hyprctl monitors -j | jq -r '.[] | .name')

  focused=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')

  for monitor in $monitors; do
    # Focus the monitor so the new window opens there
    hyprctl dispatch focusmonitor "$monitor"
    hyprctl dispatch exec 'ghostty --class=Screensaver --title=Screensaver --fullscreen --cursor-color=black --command="$HOME/.config/screensaver.sh loop_screensaver"'
  done

  hyprctl dispatch focusmonitor $focused
}

$@
