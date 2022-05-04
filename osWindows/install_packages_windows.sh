#!/usr/bin/env bash
# coding: UTF-8

function main {
    install_py
    install_js
}

function install_py {
    pip install --upgrade --no-warn-script-location \
        pip \
        pylint mypy \
        yapf \
        pytest \
        numpy scipy scikit-learn matplotlib \
        virtualenv \
        youtube_dl
}

function install_js {
    source "$(dirname "$BASH_SOURCE")/../osCommon/common_lib_js.sh"
    install_js_globals
    # install_js_globals_extra
}

main
