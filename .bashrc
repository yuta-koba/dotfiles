# completion
[ $(which terraform) ] && complete -C $(which terraform) terraform
[ $(which packer) ] && complete -C $(which packer) packer

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
