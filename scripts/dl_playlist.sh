#!/usr/bin/env bash
# coding: UTF-8

# Matija8
# Download youtube playlists with youtube-dl

# usage="Usage: ./dl_playlist.sh [-h] [-i] [-f=V[+A]]"
usage="Usage: ./dl_playlist.sh playlist_url1 pl_url2..."

# Colors:
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# while getopts ":hf" opt; do
#   case ${opt} in
#     h ) # process option h
#       ;;
#     i ) # process option i
#       ;;
#     f ) # process option f
#       ;;
#     \? ) echo $usage
#       ;;
#   esac
# done

function dl_playlist {
    printf "${GREEN}Downloading playlist${NC} ${1}${GREEN}...${NC}\n"
    youtube-dl -i -o "%(playlist_index)s %(title)s.%(ext)s" -f22 $1
    printf "${GREEN}Playlist${NC} ${1} ${GREEN}done.${NC}\n"
}

# function main {
#     printf "Starting dl_playlist.sh...\n\n"
#     for url in $@
#     do
#         dl_playlist $url
#     done
#     printf "\nFinished dl_playlist.sh\n"
# }

if [ $# -lt 1 ]; then
    printf "$usage\n"
else
    printf "${BLUE}Starting dl_playlist.sh...${NC}\n\n"
    for url in $@; do
        dl_playlist $url
    done
    printf "\n${BLUE}Finished dl_playlist.sh${NC}\n"
fi
