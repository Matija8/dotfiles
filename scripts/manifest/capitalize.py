#!/usr/bin/env python3
# encoding: UTF-8

import sys
from typing import List, Iterable, TextIO


def capitalize_files(
    files: List[str] = [],
    sort=False,
    overwrite=False,
    quiet=True,
    remove_dup=True,
    stream: TextIO = sys.stderr
) -> None:
    '''
    Capitilize all the words of text files.\n
    Params:\n
    files -> Text files to parse.\n
    sort -> Should lines of the file be sorted.\n
    overwrite -> Should the file contents be overwritten.\n
    quiet -> Don't log extra info.\n
    remove_dup -> Remove duplicates.\n
    '''
    def log_important(*args, **kwargs) -> None:
        kwargs['file'] = stream
        print(*args, **kwargs)

    def log(*args, **kwargs) -> None:
        if not quiet:
            log_important(*args, **kwargs)

    if len(files) < 1:
        log_important('No files selected!')
        return

    log('Starting...')

    for file in files:
        log(f'Reading: {file}...')
        try:
            with open(file, 'r') as lines:

                # Parse lines.
                lines = capitalize_lines(lines)

                # Remove duplicates.
                if remove_dup:
                    lines = remove_duplicates(lines)

                # Sort.
                if sort:
                    lines = sorted(lines)

                # Write output.
                if overwrite:
                    write_in_place(file, lines)
                else:
                    write_to_file_overwrite(
                        make_out_name(file, sorted=sort), lines
                    )

                log(f'File: {file} done!')

        except FileNotFoundError:
            log_important(
                'Input file: {file} not found. Please confirm file name exists.'
            )

        except Exception as e:
            log_important('Unknown exception!', e, sep='\n')

    log('All done!')


def capitalize_lines(lines: Iterable[str]) -> List[str]:
    '''
    Capitilize all the words in each line and return this as an array.
    Removes empty lines.
    '''
    out_lines = []  # type: List[str]
    for line in lines:
        if not line.isspace():
            out_lines.append(capitalize_words(line))
    return out_lines


def capitalize_words(line: str) -> str:
    ''' Capitilize first letter of each word in line. '''
    return ' '.join(word[0].upper() + word[1:] for word in line.split())


def remove_duplicates(arr: List[str]) -> List[str]:
    ''' Remove duplicates from an array of strings.'''
    # Starting with Python 3.7, the built-in dictionary
    # is guaranteed to maintain the insertion order.
    return list(dict.fromkeys(arr))


def write_to_file(out_file: str, lines: Iterable[str]) -> None:
    ''' Write lines to a new file. Fail if file exists. '''
    try:
        with open(out_file, 'x') as out:
            for line in lines:
                out.write(line + '\n')
    except FileExistsError:
        print(f'File {out_file} exists already! No changes commited.')


def write_to_file_overwrite(out_file: str, lines: Iterable[str]) -> None:
    ''' Write lines to a file, overwriting the file if it exists. '''
    try:
        with open(out_file, 'w') as out:
            for line in lines:
                out.write(line + '\n')
    except IOError:
        print('IOError!.')


write_in_place = write_to_file_overwrite


def make_out_name(in_name: str, sorted=False) -> str:
    pos = in_name.rfind('.')
    suffix = ' - capitalized' + (' & sorted' if sorted else '')
    if pos > 0:
        out_name = in_name[0:pos] + suffix + in_name[pos:]
    else:
        out_name = in_name + suffix
    return out_name


if __name__ == '__main__':
    files = sys.argv[1:]
    capitalize_files(files, sort=True, overwrite=True, quiet=False)
