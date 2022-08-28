#!/usr/bin/env python3
# coding: UTF-8

import unittest


def main():
    print('Only main runs!')
    print('For tests run this command:')
    print('\npython -m pytest\n')
    print('or just')
    print('\npytest\n')

    # Tests files must start with test_ or end with _test?


class Test(unittest.TestCase):

    def test1(self):
        given = 1 + 1
        self.assertEqual(given, 2)

    def test2(self):
        given = 1 + 2
        self.assertEqual(given, 3)


if __name__ == '__main__':
    main()
