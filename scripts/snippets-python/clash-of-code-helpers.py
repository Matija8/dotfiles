import sys
import math


def p(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr, flush=True)


def diff(a, b):
    return abs(a - b)


def mid(a, b):
    return (a + b) // 2
