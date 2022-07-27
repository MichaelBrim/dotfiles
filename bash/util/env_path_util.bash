#!/bin/bash

# functionality similar to modules prepend-path append-path remove-path

debug=0
doit="echo -n"

dbgecho() {
    if [ $debug -eq 1 ]; then
        $doit "echo DEBUG: $@ ; "
    fi
}

usage() {
    $doit "echo \"USAGE: $0 <env-var-name> args\" ; "
    $doit "echo \" (1) no args               : displays env var value (with path-style vars split at colons)\" ; "
    $doit "echo \" (2) add front|back <val>  : adds new val to front/back of path-style env var\" ; "
    $doit "echo \" (3) rm <val>              : removes val from path-style env var\" ; "
    exit 1
}

colonsplitter() {
    echo "${!1}" | sed -e 's/:/\'$'\n''/g'
}

addpath() {
    dbgecho "addpath: arg1 is $1 - arg2 is $2 - arg3 is $3"
    if [ "x`colonsplitter $1 | fgrep $3`" != "x" ]; then
        exit 0
    fi 
    if [ "$2" = "front" ]; then
        $doit "export ${1}=\"${3}:${!1}\" ; "
    elif [ "$2" = "back" ]; then
        $doit "export ${1}=\"${!1}:${3}\" ; "
    else
        usage
    fi
    exit 0
}

rempath() {
    dbgecho "rempath: arg1 is $1 - arg2 is $2"
    $doit "export ${1}="
    colonsplitter $1 | awk -v ORS=':' -v comp=$2 '$1 != comp {print}' | sed -e 's/:$//' 
    exit 0
}

if [ $# -eq 0 ]; then
    usage
elif [ $# -eq 1 ]; then
    # display value (split if path-style)
    dbgecho "arg1 is $1"
    : ${!1:? "ERROR: $1 - no such environment variable"}
    colonsplitter $1  | awk '{printf("echo %s ; ", $0)}'
    exit 0
elif [ $# -eq 3 ]; then
    if [ "$2" = "rm" ]; then
        rempath $1 $3
    fi
elif [ $# -eq 4 ]; then
    if [ "$2" = "add" ]; then
        addpath $1 $3 $4
    fi
fi
usage
