#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess


def main():
    n_of_arguments = len(sys.argv) - 1
    if n_of_arguments != 2:
        exit(f"Must have 2 arguments (video + audio)! {n_of_arguments} given.")

    video = sys.argv[1]
    audio = sys.argv[2]

    cmdList = [
        'ffmpeg', '-i', video, '-i', audio, '-c:v', 'copy', '-c:a', 'aac',
        '-strict', 'experimental', '-loglevel', 'panic', '-hide_banner'
    ]

    output_name = "STITCHED - " + video
    cmdList.append(output_name)

    start = time.time()
    print("Running ffmpeg...")

    subprocess.run(cmdList)

    end = time.time()
    print(f"Time elapsed: {end - start:.2f} seconds")


if __name__ == '__main__':
    main()
