#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess
import os.path as osp

sys.path.append(
    osp.dirname(f'{osp.dirname(osp.realpath(__file__))}/../../libPy')
)
from libPy.ffmpeg import cut_video_command
from libPy.filename import make_out_file_path_suffixed_inc


def main():
    args = sys.argv[1:4]
    if len(args) != 3:
        print(
            f'Must have 3 arguments! {len(args)} given. To omit end type "end"'
        )
        return

    input_file_path, from_time, to_time = args

    start = time.time()
    print("Running ffmpeg...")
    subprocess.run(
        cut_video_command(
            input_file_path,
            make_out_file_path_suffixed_inc(input_file_path, '-cut'), from_time,
            to_time
        )
    )
    print(f"\nTime elapsed: {time.time() - start:.2f} seconds")


if __name__ == "__main__":
    main()
