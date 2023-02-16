#!/usr/bin/env bash
# coding: UTF-8

projects_dir="$HOME/Projects"
documents_dir="$HOME/Documents"
git_ssh_base="git@github.com:Matija8"

# You need to have ssh keys setup on GitHub before running this script!

mkdir -p "$projects_dir"
if cd "$projects_dir"; then
    git clone "$git_ssh_base/dotfiles.git"
    git clone "$git_ssh_base/Random-Projects.git"
    git clone "$git_ssh_base/FE-Widget-Experiments.git"
fi

mkdir -p "$documents_dir"
if cd "$documents_dir"; then
    git clone "$git_ssh_base/Private-Docs.git"
fi
