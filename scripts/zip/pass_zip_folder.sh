#!/usr/bin/env bash
# coding: UTF-8

function zipFromCurDir {
    start=$SECONDS

    # Choice
    # read -p "Enter zip file name (without .zip): " filename
    filename="zipped"

    # Choice
    filename+=" $(date '+%Y-%m-%d')"
    # filename="$(date '+%Y-%m-%d') $filename"

    filename="$filename.zip"

    rm -f "$filename"

    printf "\nStarting zip of \"$filename\"...\n"

    # Choice
    passwd="Replace_with_own_password"
    folder_to_zip="./"

    zip \
        "$filename" \
        -q \
        -r "$folder_to_zip" \
        -P "$passwd" \
        -x "$zipped_name" ./.git/\* &&
        printf "\nZip success.\n" || printf "\nZip failure.\n"

    printSize "$filename"

    duration=$((SECONDS - start))
    printf "Zip \"$filename\" duration = $duration seconds.\n"

    # -q <- quiet
    # -r <- recursive (folder)
    # -P {pass} <- with password
    # -e <- prompt password
    # -x <- exclude (git/**)
}

function printSize {
    FILESIZE=$(stat -c%s "$1")
    echo "Size of \"$1\" = $FILESIZE bytes."
}

function main {
    # Choice
    # cd $(dirname "$0")
    zipFromCurDir
}

main
