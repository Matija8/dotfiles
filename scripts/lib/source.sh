function sourceFileQuiet {
    local file_to_source_path="$1"
    if [ -f "$file_to_source_path" ]; then
        . "$file_to_source_path"
    fi
}

function sourceFolder {
    local target_folder="$1"
    for f in "$target_folder"/*; do
        echo "Added file: $f"
        . "$f"
    done
}

function sourceDirRecursive {
    local target_folder="$1"
    local indent="$2"
    local __single_indent="    "
    $__print_sourceDirRecursive "\n$indent""Traversing dir: $target_folder\n"
    for local_path in "$target_folder"/*; do
        # full_path=$(realpath "$local_path")
        if [ -d "$local_path" ]; then
            sourceDirRecursive "$local_path" "$__single_indent$indent"
            continue
        fi
        if [[ "$local_path" == *.sh ]]; then
            $__print_sourceDirRecursive "$indent$__single_indent""Added shell script: $local_path\n"
            . "$local_path"
            continue
        fi
        $__print_sourceDirRecursive "$indent$__single_indent""Found file: $local_path\n"
    done
    # TODO
    # printf "$indent""Dir done: $target_folder\n\n"
    $__print_sourceDirRecursive "$indent""Dir done: $target_folder\n\n"
}

# https://stackoverflow.com/questions/30998558/empty-function-in-bash
# __print_sourceDirRecursive() { :; }
# __print_sourceDirRecursive=printf
# __print_sourceDirRecursive="printf -v __dump"

# https://unix.stackexchange.com/questions/594841/how-do-i-assign-a-value-to-a-bash-variable-iff-that-variable-is-null-unassigned
__print_sourceDirRecursive=${__print_sourceDirRecursive:="printf -v __dump"}
