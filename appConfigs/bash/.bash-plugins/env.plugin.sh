function printenvSorted {
    # https://stackoverflow.com/questions/60756020/print-environment-variables-sorted-by-name-including-variables-with-newlines
    env -0 | sort -z | tr '\0' '\n'
}

alias penv="printenvSorted"

# https://www.npmjs.com/package/cross-env
# npm i -g cross-env
