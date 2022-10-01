#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess
import os.path as osp

sys.path.append(
    osp.dirname(f'{osp.dirname(osp.realpath(__file__))}/../../libPy')
)
from libPy.filename import make_out_file_path_suffixed
from libPy.ffmpeg import copy_video_without_sound_cmd


def main():
    input_file_paths = sys.argv[1:]
    if len(input_file_paths) < 1:
        exit(f'Must have at least 1 argument!')

    for input_file_path in input_file_paths:
        start = time.time()
        print(f'\nRunning ffmpeg for {input_file_path}...\n')
        make_video_copy_without_sound(input_file_path)
        print(f'\nTime elapsed: {time.time() - start:.2f} seconds')


def make_video_copy_without_sound(input_file_path: str):
    subprocess.run(
        copy_video_without_sound_cmd(
            input_file_path,
            make_out_file_path_suffixed(input_file_path, ' - NO AUDIO')
        )
    )


if __name__ == '__main__':
    main()
