#!/usr/bin/env bash
# coding: UTF-8

# Generate public/private ed25519 key pair.
ssh-keygen -t ed25519 -C "matijanme@gmail.com"

# Start the ssh-agent in the background
eval $(ssh-agent -s)

# Add new key to the ssh agent.
ssh-add ~/.ssh/id_ed25519
