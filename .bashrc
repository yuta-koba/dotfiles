declare script_dir=( "${HOME}/.profile.d" "/usr/local/etc/bash_completion.d" )
for d in ${script_dir[@]};do
  for f in $(ls ${d});do
    source $d/$f
  done
done


# completion
type terraform > /dev/null && complete -C $(which terraform) terraform
type packer > /dev/null && complete -C $(which packer) packer


type dircolors > /dev/null&& eval $(dircolors ~/.dir_colors)

# completion and shortcut for 'fzf'
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
