#!/bin/bash

git clone https://github.com/junegunn/fzf.git "${GHQ_ROOT}"/github.com/junegunn/fzf
cd "${GHQ_ROOT}"/github.com/junegunn/fzf || return
bash install --xdg --key-bindings --completion --update-rc
rm ~/.zshrc
