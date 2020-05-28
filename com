#!/bin/bash

PullBranch="master"

# Check if there's something to stash
OldSha="$(git rev-parse -q --verify refs/stash)"
git stash save -q  # add options as desired here
NewSha="$(git rev-parse -q --verify refs/stash)"
if [ "$OldSha" = "$NewSha" ]; then
    MadeStashEntry=false
else
    MadeStashEntry=true
fi

# checkout master, pull, rebase 
git checkout "$PullBranch" && git pull

if [[ "$MadeStashEntry" == true && "$?" == 0 ]]
then
    git stash pop
fi

