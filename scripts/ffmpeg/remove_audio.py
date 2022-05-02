#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import time
import subprocess


#ffmpeg -i example.mkv -c copy -an example-nosound.mkv
def main():
    n_of_arguments = len(sys.argv) - 1
    if n_of_arguments < 1:
        exit(f"Must have at least 1 argument! {n_of_arguments} given.")

    for file in sys.argv[1:]:
        cmd = "ffmpeg -i -c copy -an".split()
        cmd.insert(2, file)
        index = file.rfind("/")  # last forward slash - file dir
        output = file[:index + 1] + "NO AUDIO - " + file[index + 1:]
        cmd.append(output)

        start = time.time()
        print("\nRunning ffmpeg...\n")
        subprocess.run(cmd)
        end = time.time()
        print(f"\nTime elapsed: {end - start:.2f} seconds")


if __name__ == "__main__":
    main()
