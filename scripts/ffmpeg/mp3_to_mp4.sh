#!/usr/bin/env bash
# coding: UTF-8

# https://unix.stackexchange.com/questions/657519/how-to-convert-output-mp3-to-mp4-with-ffmpeg

# ffmpeg -loop 1 -i image.jpg -i audio.mp3 -c:a copy -c:v libx264 -shortest output.mp4
audio="$1"
image="$2"
ffmpeg -loop 1 -i "$image" -i "$audio" -c:a copy -c:v libx264 -shortest output.mp4
