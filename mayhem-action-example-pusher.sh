echo 'Installing git'
apk fix && apk --no-cache --update add git

echo 'Cloning mapi'
rm -rf mapi-action-examples.git
git clone --mirror https://github.com/vlussenburg/mapi-action-examples/
cd mapi-action-examples.git
git push --set-upstream http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/mapi-action-examples.git --all
cd .. 

echo 'Cloning mcode'
rm -rf mcode-action-examples.git
git clone --mirror https://github.com/vlussenburg/mcode-action-examples/
cd mcode-action-examples.git
git push --set-upstream http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/mcode-action-examples.git --all
