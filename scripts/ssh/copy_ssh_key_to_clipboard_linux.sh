#!/usr/bin/env bash
# coding: UTF-8

sudo apt install -y xclip
# Copy the contents of the id_ed25519.pub file to clipboard.
cat ~/.ssh/id_ed25519.pub
xclip -selection clipboard <~/.ssh/id_ed25519.pub
