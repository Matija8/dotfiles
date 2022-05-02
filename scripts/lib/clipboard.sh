#!/usr/bin/env bash
# coding: UTF-8

function printWorkingDirToClipboard {
    # https://stackoverflow.com/questions/3482289/easiest-way-to-strip-newline-character-from-input-string-in-pasteboard
    pwd | tr -d '\n' | xclip -selection clipboard
}

function printQuotedWorkingDirToClipboard {
    printf "\"$(pwd)\"" | xclip -selection clipboard
}

function printPathToClipboard {
    printf "$(realpath $1)" | xclip -selection clipboard
}

function printQuotedPathToClipboard {
    printf "\"$(realpath $1)\"" | xclip -selection clipboard
}
