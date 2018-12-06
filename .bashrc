# source ~/.profile.d {{{
for f in ~/.profile.d/*.sh; do
  if [ -r "$f" ]; then
    if [ "${-#*f}" != "$-" ]; then
      . "$f"
    else
      . "$f" > /dev/null 2>&1
    fi
  fi
done
# }}}


# completion {{{
# git
for f in /usr/local/etc/bash_completion.d/*; do
  if [ -r "$f" ]; then
    if [ "${-#*f}" != "$-" ]; then
      . "$f"
    else
      . "$f" > /dev/null 2>&1
    fi
  fi
done

type terraform > /dev/null && complete -C $(which terraform) terraform
type packer > /dev/null && complete -C $(which packer) packer

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
# }}}


type dircolors > /dev/null&& eval $(dircolors ~/.dir_colors)
