#!/usr/bin/env python3
# coding: UTF-8

# Quick option:
# p = print


def p(*args, **kwargs):
    kwargs['sep'] = '\n'
    kwargs['end'] = '\n\n'
    print(*args, **kwargs)


def main():
    val1 = [1, 2, 3]
    p('val1', val1)

    val2 = [3]
    p('val1', val1, 'val2', val2)

    val3 = [4, 5]
    p({'val3': val3})


if __name__ == '__main__':
    main()
