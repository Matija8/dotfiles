#!/usr/bin/env python3
# encoding: UTF-8

import sys
from typing import List


def main():
    print("Program starting...")
    args = sys.argv
    if (len(args) < 2):
        exit("Provide more arguments!")
        #args.append("file_to_sort.txt")

    for file in args[1:]:
        print(f"File: {file} parsing...\n")
        out_lines = []  # type: List[str]
        try:
            with open(file, "r") as lines:
                for line in lines:
                    new_line = flip_first_two_words(line)
                    out_lines.append(new_line)
                write_to_file_overwrite(make_out_name(file), out_lines)
                #write_in_place(file, out_lines)
            print(f"File: {file} done...\n")
        except FileNotFoundError:
            print(
                "Input file: {file} not found. Please confirm file name exists."
            )
    print("All done!")
    return


def flip_first_two_words(line: str) -> str:
    words = line.split()
    if (len(words) < 2):
        return line.strip()
    words[0], words[1] = words[1], words[0]
    return (' '.join(words))


def write_to_file(out_file, lines: str):
    #print(f"Writing to: {out_file}...")
    try:
        with open(out_file, "x") as out:
            for line in lines:
                out.write(line.strip() + '\n')
    except FileExistsError:
        print(f"File {out_file} exists already! No changes commited.")
    return


def write_to_file_overwrite(out_file, lines: List[str]):
    try:
        with open(out_file, "w") as out:
            for line in lines:
                out.write(line.strip() + '\n')
    except IOError:
        print("IOError!.")
    return


write_in_place = write_to_file_overwrite


def make_out_name(in_name: str) -> str:
    dotPosition = in_name.rfind(".")
    suffix = ' - first two words flipped'
    if dotPosition > 0:
        return in_name[0:dotPosition] + suffix + in_name[dotPosition:]
    else:
        return in_name + suffix


if __name__ == "__main__":
    main()
