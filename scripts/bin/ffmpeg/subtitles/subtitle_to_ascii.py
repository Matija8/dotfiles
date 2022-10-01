#!/usr/bin/env python3
# coding: UTF-8

import codecs
from importlib.resources import path
import re
import sys
import os.path as osp
from typing import List

mapping = {
    'ć': 'c',
    'æ': 'c',  # ć
    'Ć': 'C',  # Ć
    'č': 'c',
    'è': 'c',  # č
    'Č': 'C',
    'È': 'C',  # Č
    'đ': 'dj',
    'ð': 'dj',  # đ
    'Đ': 'Dj',  # Đ
    'š': 's',  # š
    'Š': 'S',  # Š
    'ž': 'z',  # ž
    'Ž': 'Z',  # Ž
}
pattern = re.compile("|".join(mapping.keys()))


def replace_by_mapping(text):
    return pattern.sub(lambda m: mapping[re.escape(m.group(0))], text)


def main(subtitle_file_paths: List[str]):
    if len(subtitle_file_paths) < 1:
        print("Error: Provide at least one .srt file path!")
        exit()
    validate_files_exist(subtitle_file_paths)
    # It is asumed that all files in the argument vector have the same encoding.
    promptEncoding = 'Enter encoding for the inputed .srt files:\n' + \
    '(Common encodings for Serbian .srt subtitles are: cp1250, cp1252...)\n'
    encoding = input(promptEncoding).strip()
    for file in subtitle_file_paths:
        print(f'Fixing subtitle for {file} started...')
        to_ascii(file, encoding)


def validate_files_exist(file_paths: List[str]):
    non_existant_files = [path for path in file_paths if not osp.exists(path)]
    if len(non_existant_files) > 0:
        print(f'Error: Some files don\'t exist?!\nFiles:')
        print('\n'.join(non_existant_files))
        exit()


def to_ascii(path: str, inputFileEncoding="cp1252"):
    try:
        f = codecs.open(path, encoding=inputFileEncoding)
        contents = f.read()
        contents = pattern.sub(
            lambda m: mapping[re.escape(m.group(0))], contents
        )
        # print(contents)
        write_to_file(make_out_name(path), contents)
    except Exception as e:
        print(e)


def write_to_file(out_file, text):
    try:
        with open(out_file, "w", encoding='utf-8') as out:
            out.write(text)
    except IOError:
        print("IOError!.")
    return


def make_out_name(in_name):
    pos = in_name.rfind(".")
    suffix = '-ascii'
    if pos > 0:
        out_name = in_name[0:pos] + suffix + in_name[pos:]
    else:
        out_name = in_name + suffix
    return out_name


if __name__ == '__main__':
    main(sys.argv[1:])
