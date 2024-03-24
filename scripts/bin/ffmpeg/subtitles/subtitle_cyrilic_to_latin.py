#! /usr/bin/env python3

import sys
from typing import List


def main():
    args = sys.argv
    print("Program starting...")
    if (len(args) < 2):
        exit("Provide more arguments!")

    for file in args[1:]:
        print(f"File: {file} parsing...\n")
        parse_file(file)

    print("All done!")
    return


def parse_file(file: str):
    encoding='latin-1'
    encoding='utf-8'
    # TODO: Pass encoding as cli argument.
    try:
        with open(file, "r", encoding=encoding) as lines:
            new_lines = []
            mapp = create_map()
            for line in lines:
                new_line = []
                line_changed = False
                for letter in line:
                    try:
                        new_letter = mapp[letter]
                        line_changed = True
                    except KeyError:
                        new_letter = letter
                    new_line.append(new_letter)
                if line_changed:
                    print(f'{line} -> {new_line}')
                new_lines.append(''.join(new_line))
            write_to_file_overwrite(make_out_name(file), new_lines)
        print(f"File: {file} done...\n")
    except UnicodeDecodeError:
        print('Bad encoding!')
    except FileNotFoundError:
        print("Input file: {file} not found. Please confirm file name exists.")


def write_to_file_overwrite(out_file, lines: List[str]):
    try:
        with open(out_file, "w") as out:
            for line in lines:
                out.write(line.strip() + '\n')
    except IOError as err:
        print("IOError!.", err)
    return


def make_out_name(in_name):
    pos = in_name.rfind(".")
    if pos > 0:
        out_name = in_name[0:pos] + ' - latin.' + in_name[pos + 1:]
    else:
        out_name = in_name + ' - latin'
    return out_name


def create_map():
    cyrillic = list(
        'абвгдђежзијклљмнњопрстћуфхцчџшАБВГДЂЕЖЗИЈКЛЉМНЊОПРСТЂУФХЦЧЏШ'
    )
    latin = list('abvgddezzijkllmnnoprstcufhccdsABVGDDEZZIJKLLMNNOPRSTCUFHCCDS')
    mapping = {}
    for i in range(len(cyrillic)):
        mapping[cyrillic[i]] = latin[i]

    mapping['ђ'] = 'dj'
    mapping['Ђ'] = 'Dj'
    mapping['ж'] = 'z'
    mapping['Ж'] = 'Z'
    mapping['љ'] = 'lj'
    mapping['Љ'] = 'Lj'
    mapping['ч'] = 'c'
    mapping['Ч'] = 'C'
    mapping['џ'] = 'dz'
    mapping['Џ'] = 'Dz'
    mapping['ш'] = 's'
    mapping['Ш'] = 'S'

    return mapping


if __name__ == '__main__':
    main()
