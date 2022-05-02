#!/usr/bin/env bash
# coding: UTF-8

pip install --upgrade --no-warn-script-location \
    pip \
    pylint mypy \
    yapf \
    pytest \
    numpy scipy scikit-learn matplotlib \
    virtualenv \
    youtube_dl

npm i -g \
    nodemon prettier \
    eslint \
    http-server \
    npkill kill-port \
    depcheck \
    typescript ts-node
