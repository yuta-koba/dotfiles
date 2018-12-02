# completion
[ ! $(which terraform > /dev/null; echo $?) ] && complete -C $(which terraform) terraform
[ ! $(which packer > /dev/null; echo $?) ] && complete -C $(which packer) packer

[ ! $(which dircolors > /dev/null; echo $?) ] && eval $(dircolors ~/.dir_colors)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
