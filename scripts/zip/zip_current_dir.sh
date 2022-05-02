#!/usr/bin/env bash
# coding: UTF-8

function zip_w_passwd_prompt {
    read -p "Enter zip file name (without .zip): " filename
    filename="$filename.zip"

    zip -e "$filename" -r .
}

zip_w_passwd_prompt
