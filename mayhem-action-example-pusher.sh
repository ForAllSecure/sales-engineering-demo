echo 'Installing git'
apk fix && apk --no-cache --update add git

echo 'Cloning mapi'
git clone https://github.com/vlussenburg/mapi-action-examples/ 
cd mapi-action-examples
git push --set-upstream http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
cd .. 

echo 'Cloning mcode'
git clone https://github.com/vlussenburg/mcode-action-examples/
cd mcode-action-examples
git push --set-upstream http://root:${GITLAB_ROOT_PASSWORD}@gitlab/root/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
