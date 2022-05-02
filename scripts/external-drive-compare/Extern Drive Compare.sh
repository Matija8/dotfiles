#!/usr/bin/env bash
# coding: UTF-8

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

drive1="/media/matija/Hard Disk 1"

function main {
  checkIsD1Mounted

  "$drive1/Bjj/Compare.sh"
  "$drive1/Random/Slike/Compare.sh"
  "$drive1/Knjige/Compare.sh"

  duration=$((SECONDS - start))
  printf "\nCompare.sh: Done.\n"
  printf "Duration = $duration seconds.\n"
}

function checkIsD1Mounted {
  if [ -d "$drive1" ]; then
    true
  else
    printf "\nDrive 1 not mounted!\n"
    exit 0
  fi
}

main
