#!/usr/bin/env bash
# coding: UTF-8

# Dirs:
# Change projects_dir to "...ProjectsX" to test script works
projects_dir="$HOME/Projects"
dotfiles_dir="$projects_dir/dotfiles"

mkdir -p "$projects_dir"
cd "$projects_dir"

# TODO: github ssh key script!?

sudo apt install -y git
hash -r
gclone="git clone"

# https://github.com/Matija8?tab=repositories
$gclone git@github.com:Matija8/dotfiles.git

# Install packages
"$dotfiles_dir/osLinux/install_packages_linux.sh"

# Copy configs
"$dotfiles_dir/copy_configs.py"
