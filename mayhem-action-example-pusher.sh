#!/bin/bash

echo 'Installing git'
apk fix && apk --no-cache --update add git


for repository in mapi-action-examples mcode-action-examples
do
    rm -rf  $repository.git
    git clone --mirror https://github.com/vlussenburg/$repository/
done

while true
do
    for repository in mapi-action-examples mcode-action-examples
    do
        # -o merge_request.create tells Gitlab to automatically create a Merge Request
        ( cd $repository.git && git remote update && git push -o merge_request.create --mirror http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/$repository.git )
    done
    sleep 60
done