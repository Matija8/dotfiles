#!/usr/bin/env bash
# coding: UTF-8

# Flags:
f_flag_on=false
if [[ $* == *-f* ]]; then # if -f is in arguments
    # This hack also matches -force, -flag, -f...anything!
    f_flag_on=true
fi

if $f_flag_on; then
    printf "Flag set!\n"
fi

if $f_flag_on; then
    :
else
    printf "Flag *NOT* set!\n"
fi
