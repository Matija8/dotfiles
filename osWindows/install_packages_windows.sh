#!/usr/bin/env bash
# coding: UTF-8

os_windows_dir="$(realpath "$(dirname "$0")")"
dotfiles_root_dir="$(realpath "$os_windows_dir/..")"
source "$dotfiles_root_dir/scripts/lib/colors.sh"

function main {
    install_py
    install_js
}

function install_js {
    source "$dotfiles_root_dir/osCommon/common_lib_js.sh"
    install_js_globals
    # install_js_globals_extra
}

function install_py {
    source "$dotfiles_root_dir/osCommon/common_lib_py.sh"
    install_python_globals
}

main
