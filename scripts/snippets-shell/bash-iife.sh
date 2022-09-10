#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/12299676/is-it-feasible-to-implement-anonymous-functions-in-bash-even-using-eval-if-nec

_() {
    #...
} && _ "$@"
unset -f _
