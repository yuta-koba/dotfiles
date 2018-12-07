#!/bin/bash

function usage_docker-taglist () {
  cat <<EOF
    docker-taglist is to get docker tags and to display tag list.

    [Require]
      - docker repository name (e.g. golang or library/golang)

    Usage:
      docker-taglist (docker repository's name)
EOF
}

function docker-taglist () {
  [ -z "$1" ] && usage_docker-taglist
  curl -s https://registry.hub.docker.com/v1/repositories/"$1"/tags | jq -r ".[].name" | sort
}
