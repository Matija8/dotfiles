#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess
import os.path as path


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
            input_file_path, make_outfname(input_file_path), from_time, to_time
        )
    )
    end = time.time()
    print(f"Time elapsed: {end - start:.2f} seconds")


def cut_video_command(input_file_path, output_file_path, from_time, to_time):
    return [
        'ffmpeg', *['-ss', from_time],
        *(['-to', to_time] if to_time != 'end' else []),
        *['-i', input_file_path], *['-async', '1'], *['-strict', '-2'],
        output_file_path
    ]


def make_outfname(original_file_path):
    _dir = path.dirname(original_file_path)
    fname, ext = path.splitext(path.basename(original_file_path))
    out_path = f'{fname}-cut{ext}'
    i = 1
    while path.exists(out_path):
        out_path = f'{fname}-cut({i}){ext}'
        i += 1
    return path.join(_dir, out_path)


if __name__ == "__main__":
    main()
