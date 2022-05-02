#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess

n_of_arguments = len(sys.argv)
if n_of_arguments < 2:
    exit(f"No arguments supplied")

for file in sys.argv[1:]:
    print(file)

    cmd = f'ffmpeg -i -metadata title= -acodec copy -vcodec copy out_tmp.mp4'
    cmd = cmd + " -loglevel panic"
    cmd = cmd + " -hide_banner"
    cmd = cmd.split()
    print(cmd)
    cmd.insert(2, f'./{file}')

    start = time.time()
    print("Running ffmpeg...")
    subprocess.run(cmd)

    cmd = 'mv ./out_tmp.mp4'.split()
    cmd.append(f"./{file}")
    subprocess.run(cmd)
    end = time.time()
    print(f"Time elapsed: {end - start:.2f} seconds")
