#!/usr/bin/env python3
# encoding: UTF-8

import sys, os
from typing import List, Union
from os import PathLike


def append_order(
    n: Union[int, str], file_names: List[PathLike], quiet: bool = False
):
    """
    Take an integer n and a list of filenames. Append "n+i" (i starts from 0) to filenames where i increments for each file.
    Example:
        Input: 4 docs.txt lists.txt program.c
        Output: "4 docs.txt", "5 lists.txt", "6 program.c"
    """
    try:
        order = int(n)
    except ValueError:
        print('Starting number n is not an integer!')
        return

    if not quiet: print('Parsing...')
    for file_name in file_names:
        old_path = os.path.abspath(file_name)
        new_path = os.path.join(
            os.path.dirname(old_path),
            f'{order} {os.path.basename(old_path).strip()}'
        )
        try:
            os.rename(old_path, new_path)
            if not quiet: print(os.path.basename(new_path))
            order += 1
        except FileNotFoundError:
            print(f'Can\'t find file {file_name}, skipped.')
    if not quiet: print('Done parsing.')


def _main():
    usage = 'Usage: append_order.py starting_number filename1 filename2 filename3...'
    if len(sys.argv) < 3:
        print(usage)
        return
    append_order(sys.argv[1], sys.argv[2:], True)


if __name__ == '__main__':
    _main()
