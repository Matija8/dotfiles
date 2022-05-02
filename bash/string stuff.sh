#!/usr/bin/env bash
# coding: UTF-8

strA=$(basename "$PWD")
echo $strA
strB='bash'
# strB='notbash'

if [ "$strA" = "$strB" ]; then
    echo "Strings are equal."
else
    echo "Strings are not equal."
fi

[[ "string1" == "string2" ]] && echo "Equal" || echo "Not equal"
