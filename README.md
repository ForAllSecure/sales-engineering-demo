# Installation

- Clone the repository and cd into it
Create a `.env` file in the root with

```
GITLAB_ROOT_PASSWORD=<something complicated>
MAPI_TOKEN=<your mapi token>
```

This password will be used as both root login password, runner registration token and root API token.

Execute:
```sh
docker-compose up -d
```

The configgers should wait until Gitlab is up and running (via health check).

When the containers are up, find gitlab at localhost:8080, log in with username `root` and the password from your `.env` file.

# When you want to stop
Shut down with
```sh
docker-compose stop
```
(not `down`, since Gitlab will reinstall itself afterwards then)

Also, when it's sucking up CPU, use the `docker-compose pause` and `docker-compose unpause` commands.

# Cheat sheet
Pushing a repo into Gitlab
```sh
git push --set-upstream http://root:<password>@localhost:8080/root/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
```

Pip dependencies needed for the python3 script to get a PAT
```sh
pip3 install requests bs4 lxml
```

Gitlab allows you to mirror a Github repository but it's not available for Gitlab CE:
https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/

So we're doing it with a docker container that checks for and pushes changes every X seconds.