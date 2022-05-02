#!/usr/bin/env bash
# coding: UTF-8

# Dirs:
# Change projects_dir to "...ProjectsX" to test script works
projects_dir="$HOME/Projects"
dotfiles_dir="$projects_dir/dotfiles"
scripts_dir="$dotfiles_dir/scripts"

mkdir -p "$projects_dir"
cd "$projects_dir"

# TODO: github ssh key script!?

gclone="git clone"

# https://github.com/Matija8?tab=repositories
$gclone git@github.com:Matija8/dotfiles.git

# Install packages
"$dotfiles_dir/osLinux/install_packages_linux.sh" -f

# Copy configs
"$dotfiles_dir/copy_configs.py"

# Link scripts
"$scripts_dir/link_to_apps.sh"
