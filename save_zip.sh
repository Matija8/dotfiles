#!/usr/bin/env bash
# coding: UTF-8

function zipFromCurDir {
    start=$SECONDS

    # Choice
    # read -p "Enter zip file name (without .zip): " filename
    filename="Dotfiles"

    # Choice
    filename+=" $(date '+%Y-%m-%d')"
    # filename="$(date '+%Y-%m-%d') $filename"

    filename="$filename.zip"

    rm -f "$filename"

    printf "\nStarting zip of \"$filename\"...\n"

    # Choice
    folder_to_zip="./"

    zip \
        "$filename" \
        -q \
        -r "$folder_to_zip" \
        -x "$zipped_name" ./.git/\* ./.mypy_cache/\* ./.vscode/\* &&
        printf "Zip success.\n" || printf "Zip failure.\n"

    printSize "$filename"

    duration=$((SECONDS - start))
    printf "Zip \"$filename\" duration = $duration seconds.\n\n"

    backup "$filename"
    rm -f "$filename"
}

function printSize {
    FILESIZE=$(stat -c%s "$1")
    echo "Size of \"$1\" = $FILESIZE bytes."
}

function backup {
    # Colors:
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color

    printf "${BLUE}Backing up \"$1\"...${NC}\n"
    start=$SECONDS
    if
        rclone sync "./$1" "gdrive:Random/Zipped/Dotfiles" \
            --exclude ".git/**" \
            --exclude ".vscode/**" \
            --exclude ".mypy_cache/**" \
            --exclude "__pycache__/**"
    then
        printf "${GREEN}Backup done!${NC}\n"
    else
        printf "${RED}Backup error!${NC}\n"
    fi

    duration=$((SECONDS - start))
    printf "Backup duration = $duration seconds.\n"
}

function main {
    # Choice
    cd $(dirname "$0")
    zipFromCurDir
}

main
