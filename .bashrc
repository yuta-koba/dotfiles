declare script_dir=( "${HOME}/.profile.d" "/usr/local/etc/bash_completion.d" )
for d in ${script_dir[@]};do
  for f in $(ls ${d});do
    source $d/$f
  done
done


# completion
[ ! $(which terraform > /dev/null; echo $?) ] && complete -C $(which terraform) terraform
[ ! $(which packer > /dev/null; echo $?) ] && complete -C $(which packer) packer

[ ! $(which dircolors > /dev/null; echo $?) ] && eval $(dircolors ~/.dir_colors)

# completion and shortcut for 'fzf'
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export EDITOR=nvim

export LANG=en_US.UTF-8

export GOPATH=$HOME/src
export PATH=$GOPATH/bin:$PATH

# anyenv
export ANYENV_ROOT="$GOPATH/github.com/riywo/anyenv"
export PATH="$ANYENV_ROOT/bin:$PATH"
eval "$(anyenv init -)"
