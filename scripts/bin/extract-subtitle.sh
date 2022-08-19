#!/usr/bin/env bash
# coding: UTF-8

# https://superuser.com/questions/583393/how-to-extract-subtitle-from-video-using-ffmpeg
ffmpeg -i "$1" -map 0:s:0 subs.srt

# TODO: Rename subs.srt to input.srt if input.mp4 was $1
