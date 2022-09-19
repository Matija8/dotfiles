#!/bin/bash

# Hook should always start in the root of the repo?
# pwd

function exit_if_last_op_failed {
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

npm run test
# npm run bb # build/bundle BE
# npm run bf # build/bundle FE
# exit_if_last_op_failed
if [ $? -ne 0 ]; then exit 1; fi # Or shorter snippet version
