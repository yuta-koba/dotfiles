#!/bin/bash

function ssm-fzf () {
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

