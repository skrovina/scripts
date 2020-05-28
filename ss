#!/bin/bash

Message="$(pbpaste)"

if ! (echo "$Message" | grep "Snapshot does not match reference" >> /dev/null)
then
    >&2 echo "Focus on a failed snapshot message in Xcode!"
    exit 1
fi

Position=1
if [[ "$1" == 2 ]]
then
    Position=2
fi

SnapshotPath=$(echo "$Message" | grep -o '".*"' | head -n "$Position" | tail -n 1)
SnapshotPath="${SnapshotPath#\"}"
SnapshotPath="${SnapshotPath%\"}"

if (echo "$SnapshotPath" | grep "^/Users/travis" > /dev/null)
then
    if [[ "$Position" == 1 ]]
    then
        RepoRelativePath="${SnapshotPath#*/*/*/*/*/*/*}"
        LocalPath="$N26/$RepoRelativePath"
    else
        >&2 echo "Snapshot is not available locally!"
        exit 1
    fi
else
    LocalPath="$SnapshotPath"
fi

echo "$LocalPath"
