#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/18568706/check-number-of-arguments-passed-to-a-bash-script
# https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Illegal number of arguments"
    echo "Is $#, should be 1 or 2"
    exit
fi

input_file="$1"

# https://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
if [ ! -f "$1" ]; then
    echo "Input file $1 not found!"
    exit
fi

if [ "$#" -ne 2 ]; then
    # TODO: If only 1 file is passed, abc.mkv, the output_file should be abc.mp4
    # not out.mp4
    # https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    output_file="out.mp4"
else
    output_file="$2"
fi

# echo "Output file: $output_file"

# https://askubuntu.com/questions/396883/how-to-simply-convert-video-files-i-e-mkv-to-mp4
ffmpeg -i "$input_file" -codec copy "$output_file"
