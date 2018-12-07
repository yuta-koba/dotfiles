#!/bin/bash

function hadolint() {
  docker container run -i --rm hadolint/hadolint "$@"
}
