#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/8500326/how-to-use-nodejs-to-open-default-browser-and-navigate-to-a-specific-url

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    open_url="xdg-open"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    open_url="start"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open_url="open"
fi

$open_url https://github.com/Matija8/dotfiles
