#!/usr/bin/env bash
# coding: UTF-8

projects_dir="$HOME/Projects"
documents_dir="$HOME/Documents"

# You need to have ssh keys setup on GitHub before running this script!

mkdir -p "$projects_dir"
if cd "$projects_dir"; then
    git clone git@github.com:Matija8/dotfiles.git
    git clone git@github.com:Matija8/Random-Projects.git
    git clone git@github.com:Matija8/FE-Widget-Experiments.git
fi

mkdir -p "$documents_dir"
if cd "$documents_dir"; then
    git clone git@github.com:Matija8/Private-Docs.git
fi
