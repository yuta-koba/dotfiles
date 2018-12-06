#!/bin/bash

alias vi='nvim'

alias ll='ls -la --color'

alias ..='cd ..'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'
alias gck='git checkout'
alias gd='git diff'

alias diff='type colordiff > /dev/null && colordiff -u'

alias tpl='terraform plan | landscape'

alias fz="fzf --ansi --preview 'cat {}' --preview-window down:1"