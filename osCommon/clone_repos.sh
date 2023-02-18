#!/usr/bin/env bash
# coding: UTF-8

projects_dir="$HOME/Projects"
documents_dir="$HOME/Documents"

function git_clone_via_ssh {
    git clone "git@github.com:Matija8/$1.git"
    echo -e ""
}

# You need to have ssh keys setup on GitHub before running this script!

mkdir -p "$projects_dir"
if cd "$projects_dir"; then
    git_clone_via_ssh 'dotfiles'
    git_clone_via_ssh 'Random-Projects'
    git_clone_via_ssh 'FE-Widget-Experiments'
    cd - &>/dev/null
fi

mkdir -p "$documents_dir"
if cd "$documents_dir"; then
    git_clone_via_ssh 'Private-Docs'
    cd - &>/dev/null
fi
