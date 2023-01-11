

Gitlab allows you to mirror a Github repository but it's not available for Gitlab CE:
https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/

# Installation

- Clone the repository and cd into it
```sh
docker-compose up -d
```

Create a `.env` file in the root with

```
GITLAB_ROOT_PASSWORD=<something complicated>
GITLAB_RUNNER_REGISTRATION_TOKEN=<leave empty>
```

This password will be used as both root login password and root API token. The configgers should wait until Gitlab is up and running (via health check).

Some of them will fails, mainly because the Runner Registration token needs to be retrieved manually from http://localhost:8080/admin/runners :(.

Go to `.env` and add it once you can:

```sh
docker-compose start gitlab-runner-register
```

and if that works (a runner shows up in the UI)

```sh
docker-compose rm gitlab-runner
docker-compose create gitlab-runner
docker-compose start gitlab-runner
```

# Stop
Shut down with
```sh
docker-compose stop
```
(not `down`, since Gitlab will reinstall itself then)

Also, when it's sucking up CPU, use the `docker-compose pause` and `docker-compose unpause` commands.

# Future work

- Currently clones and pushes the current state of the Github project into Gitlab. We could modify the scripts so it can be ran multiple times where if the project already exists it pushes whatever new code we find on Github, or deletes the projects via REST API or something
- Obviously we'd love to not hardcode passwords and api keys

# Cheat sheet
Pushing a repo into Gitlab
```sh
git push --set-upstream http://root:qq6UGBwB1orpinslu3e9Tr7M0CawTv2a7U8BJbA6eNg=@localhost:8080/root/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
```

Pip dependencies needed for the python3 script to get a PAT
```sh
pip3 install requests bs4 lxml
```

# Appendix
To retrieve registration token automatically in the future
https://stackoverflow.com/questions/63137092/how-to-get-gitlab-runner-registration-token-from-command-line
