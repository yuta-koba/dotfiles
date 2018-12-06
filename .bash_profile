#!/bin/bash

if [ -e ~/.bashrc ];then
    source ~/.bashrc
fi

export LANG=en_US.UTF-8

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export EDITOR=nvim

export GOPATH=$HOME/dev
export GHQ_ROOT=$GOPATH/src
export PATH=$GOPATH/bin:$PATH

# anyenv
export ANYENV_ROOT="$GHQ_ROOT/github.com/riywo/anyenv"
export PATH="$ANYENV_ROOT/bin:$PATH"
eval "$(anyenv init -)"