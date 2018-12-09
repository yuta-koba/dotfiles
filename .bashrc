#!/bin/bash

# dircolors
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
type dircolors > /dev/null&& eval "$(dircolors ~/.dir_colors)"

# diff/git-diff
export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH

# source ~/.profile.d {{{
for file in ~/.profile.d/*.sh; do
  if [ -r "${file}" ]; then
    if [ "${-#*file}" != "$-" ]; then
      . "${file}"
    else
      . "${file}" > /dev/null 2>&1
    fi
  fi
done
# }}}

# completion {{{
# git
for file in /usr/local/etc/bash_completion.d/*; do
  if [ -r "${file}" ]; then
    if [ "${-#*file}" != "$-" ]; then
      . "${file}"
    else
      . "${file}" > /dev/null 2>&1
    fi
  fi
done

type terraform > /dev/null && complete -C "$(which terraform)" terraform
type packer > /dev/null && complete -C "$(which packer)" packer

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
# }}}

bind -x '"\C-f": ghq-fzf'
