#!/usr/bin/env bash
# coding: UTF-8

strA=$(basename "$PWD")
echo $strA
strB='bash'
# strB='notbash'

# https://linuxize.com/post/how-to-compare-strings-in-bash/
# https://stackoverflow.com/questions/2237080/how-to-compare-strings-in-bash
# https://unix.stackexchange.com/questions/67898/using-the-not-equal-operator-for-string-comparison

if [ "$strA" = "$strB" ]; then
    echo "1a - Strings are equal."
else
    echo "1b - Strings are not equal."
fi

if [ "a" != "b" ]; then
    echo "2 - Strings are not equal."
fi

if [ "a" != "b" ]; then echo "3 - Strings are not equal shorthand."; fi

[[ "string1" == "string2" ]] && echo "Equal" || echo "Not equal"
