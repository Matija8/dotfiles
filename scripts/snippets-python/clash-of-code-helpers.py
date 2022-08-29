import sys
import math


def p(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr, flush=True)


def diff(a, b):
    return abs(a - b)


def mid(a, b):
    return (a + b) // 2


def use_input_as_print_for_code_golf():
    I = input  # use uppercase I to differentiate from vars (a,b,c,r,s...)
    # I=input
    I(I())  # This 'prints' the first inputs return
    # Super useful when you have more than 1 input line!
