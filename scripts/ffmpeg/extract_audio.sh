#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/9913032/how-can-i-extract-audio-from-video-with-ffmpeg
ffmpeg -i input-video.avi -vn -acodec copy output-audio.aac
