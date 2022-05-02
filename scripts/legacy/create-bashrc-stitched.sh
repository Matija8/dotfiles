#!/usr/bin/env bash
# coding: UTF-8

# Stitch .bashrc & plugins into one file
# Status: WIP

cd $(dirname "$0")
bash_dir="../bash"
out_file_name="$bash_dir/.bashrc-stitched.sh"
>"$out_file_name"
cat "$bash_dir"/.bashrc "$bash_dir"/.bash-plugins/*.sh >>"$out_file_name"
printf "Done!\n"
