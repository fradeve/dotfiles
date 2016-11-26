#!/bin/bash
echo Running $BASH_SOURCE

python -c 'import sys; print sys.real_prefix' 2>/dev/null && INVENV=1

if [ -n "$INVENV" ];

then

    for f in $( git diff --cached --name-only --diff-filter=ACM ); do
        autopep8 --in-place $f
    done

    if [ x = x${2} ]; then
        BRANCH_NAME=$(git symbolic-ref --short HEAD)
        STORY_NUMBER=$(echo $BRANCH_NAME | sed -n 's/.*-\([0-9]\)/\1/p')
        if [ x != x${STORY_NUMBER} ]; then
            sed -i.back "1s/^.*$/$PROJECTNAME-$STORY_NUMBER: /" "$1"
        fi
    fi

fi
