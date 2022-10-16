#!/bin/bash

# Hook should always start in the root of the repo?
# pwd

function main {
    npm run test
    exit_if_last_op_failed
    # npm run bb # build/bundle BE
    # npm run bf # build/bundle FE

    t_star_do_guard
    exit_if_last_op_failed
}

function t_star_do_guard {
    # TODO:
    # Git guard against "//T*DO" !??
    # https://stackoverflow.com/questions/26835998/git-hook-to-reject-commits-where-files-contain-a-specific-string
    printf "TODO\n"

    # FILES_PATTERN='\.rb(\..+)?$'
    # FORBIDDEN='focus: true'
    # git diff --cached --name-only |
    #     grep -spec/ |
    #     grep -E $FILES_PATTERN |
    #     xargs grep --with-filename -n $FORBIDDEN && echo "COMMIT REJECTED Found '$FORBIDDEN' references. Please remove them before commiting" && exit 1
}

function exit_if_last_op_failed {
    if [ $? -ne 0 ]; then
        exit 1
    fi
    # or shorthand:
    # if [ $? -ne 0 ]; then exit 1; fi
}

main
