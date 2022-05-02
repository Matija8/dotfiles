#!/usr/bin/env bash
# coding: UTF-8

source "$(dirname "$BASH_SOURCE")/../lib.sh"

printf "Yes or no?${GREEN}(y/n)${NC}\n"
y_or_n
printf "You picked ${GREEN}yes!${NC}\n"
