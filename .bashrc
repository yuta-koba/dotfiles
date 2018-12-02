# completion
[ ! $(which terraform > /dev/null; echo $?) ] && complete -C $(which terraform) terraform
[ ! $(which packer > /dev/null; echo $?) ] && complete -C $(which packer) packer

[ ! $(which dircolors > /dev/null; echo $?) ] && eval $(dircolors ~/.dir_colors)

# completion and shortcut for 'fzf'
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
