#!/usr/bin/env bash
# coding: UTF-8

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

HARD_DISK_1="/media/matija/Hard Disk 1"
HARD_DISK_2="/media/matija/Hard Disk 2"

# Usage: sync12
#
# . "$(dirname "$0")/sync12.sh"

function example_main {
  sync_hard_12_dirs "Random/Video/"
  sync_hard_12_dirs "Bjj/"
}

function sync_hard_12_dirs {
  local suffix_path="$1"
  sync_dirs "$HARD_DISK_1/$suffix_path" "$HARD_DISK_2/$suffix_path"
}

function sync_dirs {
  printf "${GREEN}Diff:${NC}\n\n"
  rsync -avun --delete "$1" "$2"
  printf "\n${GREEN}Sync folders:${NC}\n$1\n$2\n${GREEN}(y or n):${NC} "
  if prompt_y_or_n; then
    printf "\n${GREEN}Updating $2...\n${NC}"
    rsync -avP --delete "$1" "$2"
    printf "\n${GREEN}Update done!\n${NC}\n"
  else
    printf "\n${GREEN}Update skipped!\n${NC}"
  fi
  printf "\n--------\n\n\n"
}

function prompt_y_or_n {
  while true; do
    read -p "" yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer y(yes) or n(no)." ;;
    esac
  done
}
