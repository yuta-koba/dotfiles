# Luzifer/awsenv
function setaws() {
  if [ !$(which awsenv) ];then
    echo "Not installed. [awsenv]"
    exit 1
  fi
  
  [[ $# -gt 0 ]] && eval "$(awsenv $@)";
  export TF_VAR_aws_access_key=${AWS_ACCESS_KEY_ID}
  export TF_VAR_aws_secret_key=${AWS_SECRET_ACCESS_KEY}
  export TF_VAR_aws_region=${AWS_DEFAULT_REGION}
  exec $SHELL -l
}

function ssm-fzf () {
    # Tags.Name取得
    export NAME_SSM2EC2=$(aws ec2 describe-instances \
        --query "Reservations[].Instances[].Tags[?contains(Key, \`Name\`)].Value[]" | \
      sed -e 's/[]" ,\[]//g' | \
      sed -e "/^$/d" | \
      fzf)
                                                                                                          
    # instance-id取得
    export ID_SSM2EC2=$(aws ec2 describe-instances \
        --query "Reservations[].Instances[?contains(Tags[].Value, \`${NAME_SSM2EC2}\`)].InstanceId[]" | \ 
      sed -e 's/[]" ,\[]//g' | \
      sed -e '/^$/d')
                                                                                                          
    aws ssm start-session --target ${ID_SSM2EC2}
}

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
  [ -z $1 ] && usage_docker-taglist
  REPO=$1
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r ".[].name" | sort
}

function ghq-fzf () {
  local selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    if [ -t 1 ]; then
      cd ${selected_dir}
    fi
  fi
}
bind -x '"\C-f": ghq-fzf'
