#!/usr/bin/env bash
# coding: UTF-8

cd $(dirname "$0")

function testOut {
    echo "stdout"
    echo >&2 "stderr"
}

out_path="$0-tmp.txt"
# https://superuser.com/questions/90008/how-to-clear-the-contents-of-a-file-from-the-command-line
>$out_path
testOut 2>&1 | tee -a $out_path
testOut 2>&1 | tee -a $out_path
