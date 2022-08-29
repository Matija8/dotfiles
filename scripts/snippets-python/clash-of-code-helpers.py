import sys
from math import sqrt, log2
from string import ascii_lowercase, ascii_uppercase, ascii_letters


def p(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr, flush=True)


def diff(a, b):
    return abs(a - b)


def mid(a, b):
    return (a + b) // 2


class CodeGolf:

    def use_input_as_print(self):
        I = input  # use uppercase I to differentiate from vars (a,b,c,r,s...)
        # I=input
        I(I())  # This 'prints' the first inputs return
        # Super useful when you have more than 1 input line!

    def lambda_better_than_def(self):
        I = input
        # F=lambda:int(I())
        # def F():return int(I())

        # r=1
        # F=lambda:r+1
        # def F():return r+1

        # F=lambda x:x+1
        # def F(x):return x+1

        # F=lambda x,y:x+y
        # def F(x,y):return x+y
