#!/bin/bash

function ghq-fzf () {
  selected_dir=$(ghq list --full-path | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    if [ -t 1 ]; then
      cd "${selected_dir}" || return
    fi
  fi
}

bind -x '"\C-f": ghq-fzf'
