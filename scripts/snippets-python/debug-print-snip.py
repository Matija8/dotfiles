#!/usr/bin/env python3
# coding: UTF-8

# Quick options:
# p = print

# dir, vars:
# https://datagy.io/python-print-objects-attributes/

# The type function:
# https://www.programiz.com/python-programming/methods/built-in/type
# https://www.digitalocean.com/community/tutorials/python-type
# https://stackoverflow.com/questions/1549801/what-are-the-differences-between-type-and-isinstance


def p(*args, **kwargs):
    kwargs['sep'] = '\n'
    # kwargs['end'] = '\n\n'
    # end='\n\n' can be bad for var regions (REGION LABEL)
    print(*args, **kwargs)


class Dog:

    def __init__(self):
        self.age = 5
        self.name = 'Rex'


def main():
    val1 = [1, 2, 3]
    p('val1', val1)

    val2 = [3]
    p('\nval1', val1, 'val2', val2)

    val3 = [4, 5]
    p('\n', {'val3': val3})

    # This is for lib classes, like pandas models...
    p('\nval3 object fields/keys/attrs', dir(val3))

    p('\nDog object fields/keys/attrs', dir(Dog()))

    p('\nDog object data fields & values', vars(Dog()))

    p('\nDog object type', type(Dog()))

    p('\nREGION LABEL')
    p(val1)
    p(val2)
    p(val3)
    p('\n\n')


if __name__ == '__main__':
    main()
