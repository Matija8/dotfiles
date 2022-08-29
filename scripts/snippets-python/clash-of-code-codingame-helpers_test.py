import sys
from math import sqrt, log2
from string import ascii_lowercase, ascii_uppercase, ascii_letters


def p(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr, flush=True)


def diff(a, b):
    return abs(a - b)


def mid(a, b):
    return (a + b) / 2
    # return (a + b) // 2


def length(arr):
    return len(arr)


def bin_hex(char):
    number = 435
    print(number, 'in hex =', hex(number))
    print(number, 'in bin =', bin(number))
    number = 2.5
    print(number, 'in hex =', float.hex(number))


def hset_diff():
    # https://www.geeksforgeeks.org/python-set-difference/
    dif = set(ascii_uppercase) - set(ascii_uppercase[:-3])
    # p(dif) # {'X', 'Z', 'Y'}
    return dif


def has_consec_letters(word):
    # word = 'tupple'  # pp consecutive
    a = zip(word, word[1:])
    has_consec = any([x[0] == x[1] for x in a])
    return has_consec


def arrMap(arr, f):
    return [f(x) for x in arr]


def arrFilter(arr, f):
    return [x for x in arr if f(x)]


def reverse_string(input_str):
    # https://www.w3schools.com/python/python_howto_reverse_string.asp
    return input_str[::-1]


def unicode_order():
    # https://www.programiz.com/python-programming/methods/built-in/ord
    print(ord('5'))  # 53
    print(ord('A'))  # 65
    print(ord('$'))  # 36


def str_ops(in_str: str):
    print(in_str.count('substr'))
    # https://stackoverflow.com/questions/6005891/replace-first-occurrence-only-of-a-string
    print(in_str.replace('old', 'new', 1))
    print(in_str.replace('old', 'new'))
    print(in_str.index('substr'))
    print(in_str.find('substr') != -1)
    print(in_str.isnumeric())
    print(in_str.isupper(), in_str.islower())


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

    def use_bool_as_0_or_1(self):
        cond = 1 > 2
        print(['YES', 'NO'][cond])


import unittest


class Test(unittest.TestCase):

    def test_diff(self):
        given = diff(5, -5)
        self.assertEqual(given, 10)

    def test_mid(self):
        given = mid(-5, 6)
        self.assertEqual(given, 0.5)

    def test_len(self):
        self.assertEqual(length([1, 2]), 2)

    def test_set_diff(self):
        self.assertEqual(len(hset_diff()), 3)

    def test_has_consec_letters(self):
        self.assertEqual(has_consec_letters('asd'), False)
        self.assertEqual(has_consec_letters('huddle'), True)

    def test_arr_map_filter(self):
        givenArr = [1, 2, 3, 4]
        self.assertEqual(arrMap(givenArr, str)[2], '3')
        filteredArr = arrFilter(givenArr, lambda x: x > 1)
        self.assertEqual(filteredArr[0], 2)
        self.assertEqual(len(filteredArr), 3)
        mappedAndFilteredArr = [str(x) for x in givenArr if x > 2]
        self.assertEqual(mappedAndFilteredArr, ['3', '4'])

    def test_reverse_str(self):
        self.assertEqual(reverse_string("Hello World"), 'dlroW olleH')
