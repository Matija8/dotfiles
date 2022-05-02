#!/usr/bin/env bash
# coding: UTF-8

RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # Reset color to neutral

function printInColor {
    printf "$1$2${NC}"
}

function printGreen {
    printInColor $GREEN $1
}
