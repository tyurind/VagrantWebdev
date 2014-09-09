#!/bin/bash
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
cd "$DIR/../.."

## $ Current machine states:
## $
## $ default                   aborted (virtualbox)
## $ default                   running (virtualbox)
MSG=$(vagrant status | sed -n '/running (virtualbox)/p')
if [[ "$MSG" == "" ]]; then
    vagrant up
fi
##

vagrant ssh $*
