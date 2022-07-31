#!/usr/bin/env bash
# coding: UTF-8

# This is an incomplete script.
# The motivation for this was Code Artifact token for Apps repo.
# That token needs to be refreshed every 12hrs and persisted between
# bash sessions. If 12hrs didn't pass, reuse the persisted token.

env_dir="$HOME/_Matija-Scripts/_env"
# https://askubuntu.com/questions/800845/create-file-and-its-parent-directory
mkdir -p "$env_dir"
env_path="$env_dir/test-last-update-time.txt"

# https://stackoverflow.com/questions/7427262/how-to-read-a-file-into-a-variable-in-shell
last_epoch_time_in_s=$(cat $env_path)

# https://serverfault.com/questions/151109/how-do-i-get-the-current-unix-time-in-milliseconds-in-bash
current_epoch_time_in_s=$(date +%s)
# echo $current_epoch_time_in_s

# TODO
# If last_epoch_time_in_s is empty or
# last_epoch_time_in_s + time_limit > current_epoch_time_in_s
# then set value at env_path to current_epoch_time_in_s

# https://linuxize.com/post/bash-write-to-file/
# echo current_epoch_time_in_s >"$env_path"
