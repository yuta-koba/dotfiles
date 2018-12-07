#!/bin/bash

function setaws () {
  if [ ! "$(type awsenv &> /dev/null)" ];then
    echo "Not installed. [awsenv]"
    exit 1
  fi

  [[ $# -gt 0 ]] && eval "$(awsenv "$@")";
  export TF_VAR_aws_access_key=${AWS_ACCESS_KEY_ID}
  export TF_VAR_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
  export TF_VAR_aws_region=${AWS_DEFAULT_REGION}
}

