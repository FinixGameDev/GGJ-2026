#!/bin/sh
printf '\033c\033]0;%s\a' GGJ_2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/mask_minotaur.x86_64" "$@"
