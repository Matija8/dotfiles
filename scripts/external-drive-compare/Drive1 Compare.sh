#!/usr/bin/env bash
# coding: UTF-8

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

eksterni_path="/media/matija/Eksterni Hard/"

function main {

  checkIsEksterniMounted

  eksterni_dir="$eksterni_path/Random/Slike"
  local_dir=$(dirname "$0")

  if [[ $local_dir -ef $eksterni_dir ]]; then
    printf "\nRunning from Eksterni! Change directory to local fs!\n"
    exit 0
  fi

  cd "$local_dir"
  start=$SECONDS

  compareDirs "2008 - 2009"
  compareDirs "2014 - 2020 09"
  compareDirs "2020 09 - 2021 07"
  compareDirs "Wallpaper"

  compareFiles "Compare.sh" "" "Compare.sh scripts are different!"

  duration=$((SECONDS - start))
  printf "\nCompare.sh: Done.\n"
  printf "Duration = $duration seconds.\n"
}

function compareDirs {
  printf "\nComparing '$1' with '$1':\n"

  if rclone check --size-only "./$1" "$eksterni_dir/$1"; then
    printf "${GREEN}Good!${NC}\n"
  else
    printf "${RED}Bad!${NC}\n"
  fi
}

function compareFiles {
  file="$1"
  succMsg="$2"
  errMsg="$3"

  if cmp -s "./$file" "$eksterni_dir/$file"; then
    printf "${GREEN}${succMsg}${NC}\n"
  else
    printf "\n${RED}${errMsg}${NC}\n"
  fi
}

function checkIsEksterniMounted {
  if [ -d "$eksterni_path" ]; then
    true
  else
    printf "\nEksterni not mounted!\n"
    exit 0
  fi
}

main
