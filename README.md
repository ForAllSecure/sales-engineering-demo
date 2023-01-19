

Gitlab allows you to mirror a Github repository but it's not available for Gitlab CE:
https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/

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

# Gitlab project manual setup work (for now, can be automated)

- Go to localhost:8080 and log in
- Go to Projects > mapi-action-examples
- Go to Settings > Merge Request and enable merge requests to require a successful pipeline request
- Go to merge request and create a new one from `bad-login-endpoint` to `main`
- ???
- Profit!

# When you want to stop
Shut down with
```sh
docker-compose stop
```
(not `down`, since Gitlab will reinstall itself afterwards then)

Also, when it's sucking up CPU, use the `docker-compose pause` and `docker-compose unpause` commands.

# Future work

- Currently clones and pushes the current state of the Github project into Gitlab. We could modify the scripts so it can be ran multiple times where if the project already exists it pushes whatever new code we find on Github, or deletes the projects via REST API or something
- Obviously we'd love to bypass the runner registration token. There's some links in the Appendix, it seems doable.

# Cheat sheet
Pushing a repo into Gitlab
```sh
git push --set-upstream http://root:<password>@localhost:8080/root/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
```

Pip dependencies needed for the python3 script to get a PAT
```sh
pip3 install requests bs4 lxml
```