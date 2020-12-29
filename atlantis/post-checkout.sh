#!/bin/bash
## Make sure to give execution permissions.
# Checks if a post-checkout.sh script exists in `atlantis-hooks` folder in order to auto-run that.
PWD=`pwd`
FILE=$PWD/atlantis-git-hooks/repo-post-checkout.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists in the repo $PWD."
    exec $FILE
else
    echo "$FILE does not exist in the repo $PWD."
fi