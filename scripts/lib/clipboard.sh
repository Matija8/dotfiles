#!/usr/bin/env bash
# coding: UTF-8

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    __clip="xclip -selection clipboard"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    __clip="clip"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    __clip="pbcopy"
fi

function printWorkingDirToClipboard {
    # https://stackoverflow.com/questions/3482289/easiest-way-to-strip-newline-character-from-input-string-in-pasteboard
    pwd | tr -d '\n' | $__clip
}

function printQuotedWorkingDirToClipboard {
    printf "\"$(pwd)\"" | $__clip
}

function printPathToClipboard {
    printf "$(realpath $1)" | $__clip
}

function printQuotedPathToClipboard {
    printf "\"$(realpath $1)\"" | $__clip
}
