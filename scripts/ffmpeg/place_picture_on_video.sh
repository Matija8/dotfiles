#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/48667345/how-to-replace-all-frames-of-video-to-one-image
# This also changes resolution! BAD
# ffmpeg -i video -i image -filter_complex "[1][0]scale2ref[i][v];[v][i]overlay" -c:a copy out.mp4

# TODO: Good solution
