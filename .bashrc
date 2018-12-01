# terraform-completion
if [ $(which terraform) ];then
  complete -C $(which terraform) terraform
fi

# packer-completion
if [ $(which packer) ];then
  complete -C $(which packer) packer
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
