#!/usr/bin/env bash
# coding: UTF-8

# This script is no longer used.
# I used to use it for TC-Law-All, when I kept TC-Law-FE as a sepearte repo
exit

cd $(dirname "$0")

# https://stackoverflow.com/questions/1030169/easy-way-to-pull-latest-of-all-git-submodules
git submodule update --init --recursive
cd frontend
git checkout main

# For ssh access (not https) change:
# 1) .gitmodules
# 2) .git/config
#
# https://stackoverflow.com/questions/913701/how-to-change-the-remote-repository-for-a-git-submodule
# https://stackoverflow.com/questions/6031494/git-submodules-and-ssh-access
# https://stackoverflow.com/a/6031586
#
# Example:
# [submodule "REPO"]
# 	active = true
# 	url = https://github.com/ORG/REPO.git
#     ->
# 	url = git@github.com:ORG/REPO.git
