function __lib_source {
    local lib_dir="$(dirname "$BASH_SOURCE")/lib"
    source "$lib_dir/source.sh"
    # __print_sourceDirRecursive=printf
    sourceDirRecursive "$lib_dir"
    # printf "${GREEN}If this is green, lib was sourced!${NC}\n\n"
}

__lib_source
