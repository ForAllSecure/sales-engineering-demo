#!/bin/bash

echo 'Installing git'
apk fix && apk --no-cache --update add git curl


for repository in mapi-action-examples mcode-action-examples
do
    rm -rf  $repository.git
    git clone --mirror https://github.com/ForAllSecure/$repository/
done

while true
do
    for repository in mapi-action-examples mcode-action-examples
    do
        # -o merge_request.create tells Gitlab to automatically create a Merge Request
        ( cd $repository.git && git remote update && git push -o merge_request.create --mirror http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/$repository.git )

        # enable only_allow_merge_if_pipeline_succeeds for repository
        curl -o /dev/null -s -w "%{http_code}\n" -X PUT --header "PRIVATE-TOKEN: ${GITLAB_ROOT_PASSWORD}" --header 'Content-Type: application/json;charset=UTF-8' http://gitlab/api/v4/projects/root%2F$repository -d '{"only_allow_merge_if_pipeline_succeeds": true}'
    done
    sleep 600
done