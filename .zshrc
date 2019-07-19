bindkey -v

# ### Aliases {{{
alias E='exec $SHELL -l'

alias v='nvim'
alias vi='nvim'

alias cp='cp -i'
alias mv='mv -i'
alias l='ls -Ga'
alias ll='ls -lGa'
alias ..='cd .. && ll'
alias ...='cd ../../ && ll'
alias gs='git status'
alias gp='git pull'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'
alias gd='git diff'
alias gdc='git diff --cached'
alias cdg='cd ~/dev/src/github.com/yuta_kobayashi/gist'

#alias diff='type colordiff > /dev/null && colordiff -u || diff'
alias diff='colordiff'
alias dc='docker-compose'

alias cfn='aws cloudformation'
# }}}

# ### Option {{{
setopt correct # suggest correct when typo

setopt no_beep      # no more beep
setopt no_list_beep # no beep at ls completion
setopt no_hist_beep # no beep at hist completion

setopt print_eight_bit # enable 8bit char-set

setopt share_history      # share command history in other pane/window
setopt hist_ignore_dups   # ignore duplicated command
setopt hist_ignore_space  # ignore command starting with space
setopt hist_reduce_blanks # reduce unnecessary space when command will save in history
setopt inc_append_history # immediately write history
setopt append_history     # write to history file
# }}}

# ### zstyle {{{
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# }}}


# ### zplug {{{
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  # Essentials {{{
  ZPLUG_PROTOCOL=https

  zplug "zsh-users/zsh-history-substring-search"
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  
  zplug "zsh-users/zsh-completions"
  zplug "glidenote/hub-zsh-completion"
  zplug "Valodim/zsh-curl-completion"
  zplug "aws/aws-cli", use:"bin/aws_zsh_completer.sh"

  # prompt
  zplug "modules/git", from:prezto
  zplug "modules/prompt", from:prezto
  zstyle ':prezto:module:git:alias' skip 'yes'
  zstyle ':prezto:module:prompt' theme 'sorin'

  zplug "koron/gtc",                            as:command, hook-build:'go get -d && go build'
  zplug "junegunn/fzf-bin",                     as:command, from:gh-r, rename-to:"fzf"
  zplug "junegunn/fzf",                         use:"shell/(completion|key-bindings).zsh"
  zplug "stedolan/jq",                          as:command, from:gh-r, rename-to:"jq"
  zplug "motemen/ghq",                          as:command, from:gh-r, rename-to:"ghq"
  zplug "monochromegane/the_platinum_searcher", as:command, from:gh-r, rename-to:"pt"
  zplug "github/hub",                           as:command, from:gh-r, rename-to:"hub"
  zplug "jonas/tig",                            as:command, hook-build:"make", use:"src/tig"
  zplug "awslabs/git-secrets",                  as:command, hook-build:"PREFIX=~/.zplug make install"
  zplug "daveewart/colordiff",                  as:command, at:current, use:"colordiff.pl", rename-to:"colordiff"

  zplug "direnv/direnv",                        as:command, from:gh-r, rename-to:"direnv", hook-build:"chmod 755 direnv\.*"
  if [[ $(type dirne) > /dev/null ]];then
    eval "$(direnv hook zsh)"
  fi
  # }}}

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
    echo
  fi
  zplug load
fi
# }}}

PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{4}${_prompt_sorin_pwd} ${_prompt_sorin_git}%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '
PROMPT+="%B%F{1}>%f%F{3}>%f%F{6}>%f%b "
RPROMPT=''

# ### function {{{
ghq-fzf() {
  selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    if [ -t 1 ]; then
      cd "${selected_dir}" || return
    fi
  fi
}
zle     -N   ghq-fzf
bindkey '^G' ghq-fzf

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
zle     -N   fd
bindkey '^F' fd

dtls() {
  if [[ -z $REGISTRY_URL ]]; then
    REGISTRY_URL="https://registry.hub.docker.com/v1/repositories"
  fi
  #curl -s https://registry.hub.docker.com/v1/repositories/"$1"/tags | jq -r ".[].name" | sort
  curl -s $REGISTRY_URL/"$1"/tags | jq -r ".[].name" | sort | fzf --height=40%
}

dpull() {
 tag="$(dtls $1)"
 docker pull $1:"$tag"
}

drmi() {
  image="$(docker images | fzf --height=40% --reverse --header-lines=1 | awk '{print $3}')"
  docker rmi $image
}

drmf() {
  proc="$(docker ps -a | fzf --height=40% --reverse --header-lines=1 | awk '{print $1}')"
  docker kill $proc && docker rm $proc
}

drm() {
  proc="$(docker ps | fzf --height=40% --reverse --header-lines=1 | awk '{print $1}')"
  docker stop $proc && docker rm $proc
}

ssm-fzf() {
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

  aws ssm start-session --target ${id_ssm2ec2}
}

hadolint() {
  docker container run -i --rm hadolint/hadolint "$@"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
