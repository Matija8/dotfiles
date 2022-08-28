#!/usr/bin/env python3
# coding: UTF-8

from dataclasses import dataclass
from collections import namedtuple

# https://stackoverflow.com/questions/51671699/data-classes-vs-typing-namedtuple-primary-use-cases


def dataClassExample():
    # https://docs.python.org/3/library/dataclasses.html
    print('dataClassExample WIP')


def namedTupleExample():
    # https://www.geeksforgeeks.org/namedtuple-in-python/

    # Declaring namedtuple()
    Student = namedtuple('Student', ['name', 'age', 'DOB'])

    # Adding values
    S = Student('Nandini', '19', '2541997')

    # initializing iterable
    li = ['Manjeet', '19', '411997']

    # initializing dict
    di = {'name': "Nikhil", 'age': 19, 'DOB': '1391997'}

    # using _make() to return namedtuple()
    print("The namedtuple instance using iterable is  : ")
    print(Student._make(li))

    # using _asdict() to return an OrderedDict()
    print("The OrderedDict instance using namedtuple is  : ")
    print(S._asdict())

    # using ** operator to return namedtuple from dictionary
    print("The namedtuple instance from dict is  : ")
    print(Student(**di))


def main():
    namedTupleExample()
    dataClassExample()


if __name__ == '__main__':
    main()
