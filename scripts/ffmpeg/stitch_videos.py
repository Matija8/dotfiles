#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import sys
import time
import subprocess

def main():
    n_of_arguments = len(sys.argv)
    if n_of_arguments < 3:
        exit(f"Must have at least 2 arguments! {n_of_arguments-1} given.")

    files = sys.argv[1:]

    txt = "TMP - " + files[0] + ".txt"
    output = "STITCH - " + files[0]

    f = open(txt , "w+")
    for i in range(n_of_arguments-1):
        f.write("file '" + os.path.abspath(files[i]).replace("'", "\\'") + "' \n")
    f.close()

    cmd = "ffmpeg -f concat -safe 0 -i -c copy".split()
    cmd.insert(6, txt)
    cmd.append(output)

    start = time.time()
    print("\nRunning ffmpeg...\n")
    subprocess.run(cmd)
    end = time.time()
    print(f"\nTime elapsed: {end - start:.2f} seconds\n")

    os.remove(txt)


if __name__ == "__main__":
    main()
