#!/bin/bash

usage="USAGE: $0 session-name working-dir [num-windows]"
if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo "ERROR: $0 - incorrect usage"
    echo $usage
    exit 1
fi

sname=$1
wdir=$2
nwin=${3:-3}

#echo "DEBUG: session name is $sname, number of windows is $nwin"

# make new bash programs reload environment/aliases
[[ -n $HAVE_MJB_BASH_CONFIG ]] && unset HAVE_MJB_BASH_CONFIG

# create detached session with requested name
tmux new-session -d -c $wdir -s $sname || { echo "ERROR: $0 - session with name $sname exists"; exit 1;}

# create requested number of windows, starting at 2
for (( w=2; w <= $nwin; w++ )); do
    tmux new-window -t ${sname}:$w 
done

# choose window 1 as current selection
tmux select-window -t ${sname}:1

# attach to the session
tmux attach-session -t $sname
