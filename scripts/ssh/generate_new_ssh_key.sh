#!/usr/bin/env bash
# coding: UTF-8

# GitHub docs:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh

# First check if you already have an ssh key
printf "Existing public ssh key files:\n"
ls -a ~/.ssh/*.pub
printf "\n"

read -p "Are you sure? (Ctrl+c to cancel)" yn

# Generate public/private ed25519 key pair.
ssh-keygen -t ed25519 -C "matijanme@gmail.com"

# Start the ssh-agent in the background
eval $(ssh-agent -s)

# Add new key to the ssh agent.
ssh-add ~/.ssh/id_ed25519
