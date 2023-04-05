# Introduction

This project creates a demo environment for Mayhem with gitlab-ce and jenkins. It prepopulates both servers with the mayhem-example repositories and automates the creation of all merge requests, jobs, etc to demo both Mayhem for Code and Mayhem for API.

# Installation

- Clone the repository and cd into it
1. Create a `.env` file in the root with

```env
# This password will be used as both root login password, runner registration token and root API token.
GITLAB_ROOT_PASSWORD=<something complicated>
# The admin password to log in to Jenkins
JENKINS_ADMIN_PASSWORD=<something complicated>
MAPI_TOKEN=<your mapi token>
MAYHEM_TOKEN=<your mayhem for code token>
MAYHEM_URL=https://demo.forallsecure.com
MAYHEM_USERNAME=<youruser>@forallsecure.com
# If you are on a M1 Mac (arm processor), add this and otherwise, comment the line.
GITLAB_IMAGE_OVERRIDE=yrzr/gitlab-ce-arm64v8
```

2. Execute:
```sh
docker-compose up -d
```

The configgers should wait until Gitlab is up and running (via health check).

When the containers are up, find gitlab at localhost:8080, log in with username `root` and the password from your `.env` file. Find jenkins at localhost:8081, log in with username `admin` and the password from your `.env` file.

# When you want to stop
Shut down with
```sh
docker-compose stop
```
(not `down`, since Gitlab will reinstall itself afterwards then)

Also, when it's sucking up CPU, use the `docker-compose pause` and `docker-compose unpause` commands.

# Known issues

- My job didn't fail but it was supposed to / my job failed but it wasn't supposed to
- Sometimes, a python process is left running (bc uvicorn can't cleanly shut down using external command, you have to kill it - maybe use a different runner?) which means multiple jobs use the same python process, and thus are not getting different results. It's easiest to just restart the Jenkins/Gitlab-Runner node and rerun the job with unexpected results. A ticket to fix this better can be found [here](https://trello.com/c/InBu1Ydq/13-fix-port-is-already-in-use-for-python-api-example-jenkins-gitlab)

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
