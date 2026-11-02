#!/usr/bin/env sh
# Copy of /usr/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh that
# sanitizes the suggested file name when saving.
#
# For more information about input/output arguments read `xdg-desktop-portal-termfilechooser(5)`

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
debug="$6"

shift 6 # remaining positional args are TERMCMD

set -e

if [ "$debug" = 1 ]; then
    set -x
fi

cmd="yazi"

# The portal shell-escapes the suggested path ( ' -> '\'' ) although it is
# passed as a plain argument; undo that, then replace awkward characters in the
# file name with '_', moving the portal's placeholder file along.
moved_placeholder=0
if [ "$save" = "1" ]; then
    path=$(printf '%s' "$path" | sed "s/'\\\\''/'/g")
    dir=$(dirname -- "$path")
    name=$(basename -- "$path" | sed 's/[^[:alnum:]._-]/_/g; s/__*/_/g')
    clean="$dir/$name"
    if [ "$clean" != "$path" ]; then
        if [ -e "$path" ] && [ ! -e "$clean" ]; then
            mv -- "$path" "$clean"
            moved_placeholder=1
        fi
        path="$clean"
    fi
fi

run_command() {
    if [ "$save" = "1" ]; then
        # save a file
        set -- "$@" $cmd --chooser-file="$out" "$path"
    elif [ "$directory" = "1" ]; then
        # upload files from a directory
        set -- "$@" $cmd --chooser-file="$out" --cwd-file="$out"".1" "$path"
    elif [ "$multiple" = "1" ]; then
        # upload multiple files
        set -- "$@" $cmd --chooser-file="$out" "$path"
    else
        # upload only 1 file
        set -- "$@" $cmd --chooser-file="$out" "$path"
    fi

    "$@" # this runs the whole command: $TERMCMD $cmd $@
}
run_command "$@" # $@ == TERMCMD

# On cancel the portal removes its placeholder, but it no longer knows ours
if [ "$moved_placeholder" = 1 ] && [ ! -s "$out" ]; then
    rm -f -- "$path"
fi

if [ "$directory" = "1" ]; then
    if [ ! -s "$out" ] && [ -s "$out"".1" ]; then
        cat "$out"".1" > "$out"
        rm "$out"".1"
    else
        rm "$out"".1"
    fi
fi
