#!/usr/bin/env bash
# coding: UTF-8

# Cd to script directory
cd $(dirname "$0")

# Cd to previous dir
cd -

# Print current working dir.
# Good for checking if mkdir & cd worked
pwd

# Pipe stderr & stdout to file
echo "Stuff" &>"./test-file.txt"

# Discard stderr & stdout
echo "Stuff" &>/dev/null

# Sleep/wait
sleep 5s

# Clear file contents
# https://superuser.com/questions/90008/how-to-clear-the-contents-of-a-file-from-the-command-line
>"$out_file_name"
