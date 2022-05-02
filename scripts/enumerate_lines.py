#!/usr/bin/env python3
# encoding: UTF-8

import sys

set_encoding = "UTF-8"


def main():
    lines = []
    for file_name in sys.argv[1:]:
        lines = get_lines(file_name)
        if lines == None:
            return
        write_with_line_numbers(file_name, lines)
    return


def get_lines(file_name=""):
    try:
        with open(file_name, "r+", encoding=set_encoding) as file:
            lines = file.readlines()
    except IOError as e:
        print(e)
        return None
    return lines


def write_with_line_numbers(file_name="", lines=[]):
    try:
        with open(file_name, "w+", encoding=set_encoding) as file:
            i = 1
            digit_length = line_number_length(len(lines))
            for line in lines:
                line_number = fill_line_number(i, digit_length)
                line = line_number + ' ' + line
                file.write(line)
                i += 1
            file.flush()
    except IOError as e:
        print(e)
    return


def line_number_length(number_of_lines):
    return len(str(number_of_lines))


def fill_line_number(i, length):
    i = str(i)
    while len(i) < length:
        i = '0' + i
    return i


if __name__ == "__main__":
    main()
