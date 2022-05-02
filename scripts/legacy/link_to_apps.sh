#!/usr/bin/env bash
# coding: UTF-8

GREEN='\033[0;32m'
NC='\033[0m'

# Change working directory to this scripts directory.
# Not the symlink directory!
scriptPath=$(readlink -f "$0")
srcDir=$(dirname "$scriptPath")
cd "$srcDir"
targetDir="$HOME/_Matija-Scripts/"

# Deprecated warning
printf "Deprecated! Exiting...\n\n"
exit

printf "${GREEN}Linking from $srcDir to $targetDir${NC}\n\n"
# rm -rf targetDir
mkdir -p "$targetDir"

files_to_link=(
    .gupdate.sh
    cc.sh
    clear_port.sh
    dl_playlist.sh
    ffmpeg/cut.py
    ffmpeg/remove_title_tag.py
    gupdate.sh
    js/js-list-global-packages.sh
    link_to_apps.sh
    qupdate.sh
    subtitles/subtitle_to_ascii.py
    youtube-dl-hd.sh
    zip/zip_current_dir.sh
)
# TODO: Add
# rclone/rcbackup.sh
# rclone/rccheck.sh

# https://stackoverflow.com/questions/47367985/expanding-a-bash-array-only-gives-the-first-element
for file_path in ${files_to_link[@]}; do
    file_basename=$(basename $file_path)
    printf "Updating $file_basename\n"
    ln -sf "$(pwd)/$file_path" "$targetDir/$file_basename"
done

# TODO: get current user shell??
# After calling this script call
# $ hash -r
# if in bash, or
# $ rehash
# if in zsh,
# where $ is the shell prompt.

printf "\n${GREEN}Linking done!${NC}\n"
