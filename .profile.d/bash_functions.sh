#!/bin/bash

function ghq-fzf() {
  selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    if [ -t 1 ]; then
      cd "${selected_dir}" || return
    fi
  fi
}

function setaws() {
  type awsenv > /dev/null || exit 1
  [[ $# -gt 0 ]] && eval "$(awsenv "$@")";
  export TF_VAR_aws_access_key=${AWS_ACCESS_KEY_ID}
  export TF_VAR_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
  export TF_VAR_aws_region=${AWS_DEFAULT_REGION}
}

function docker-taglist() {
  [ -z "$1" ] && { usage; exit 1; }
  curl -s https://registry.hub.docker.com/v1/repositories/"$1"/tags | jq -r ".[].name" | sort
}

function hadolint() {
  type docker > /dev/null || exit 1
  docker container run -i --rm hadolint/hadolint "$@"
}

function ssm-fzf() {
  type aws > /dev/null || exit 1

  # Tags.Name取得
  name_ssm2ec2=$(aws ec2 describe-instances \
      --query "Reservations[].Instances[].Tags[?contains(Key, \`Name\`)].Value[]" | \
    sed -e 's/[]" ,\[]//g' | \
    sed -e "/^$/d" | \
    fzf)

  # instance-id取得
  id_ssm2ec2=$(aws ec2 describe-instances \
      --query "Reservations[].Instances[?contains(Tags[].Value, \`${name_ssm2ec2}\`)].InstanceId[]" | \
    sed -e 's/[]" ,\[]//g' | \
    sed -e '/^$/d')

  aws ssm start-session --target "${id_ssm2ec2}"
}
