export LANG=ja_JP.UTF-8
export TERM=screen-256color
export EDITOR='nvim'

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache

# go
export GO111MODULE=on
export GOPATH=$HOME/dev
#export GOROOT=$HOME/dev
export PATH=$GOPATH/bin:$PATH

# ghq
export GHQ_ROOT=$GOPATH/src

# anyenv
#export GOENV_DISABLE_GOROOT=1
export GOENV_DISABLE_GOPATH=1
export ANYENV_ROOT=/Users/lunarxlark/dev/src/github.com/anyenv/anyenv
export PATH=$ANYENV_ROOT/bin:$PATH
eval "$(anyenv init -)"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export PATH=/usr/local/share/git-core/contrib/diff-highlight:$PATH
