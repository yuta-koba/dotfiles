#!/bin/bash

git clone https://github.com/junegunn/fzf.git ~/src/github.com/junegunn/fzf
cd ~/src/github.com/junegunn/fzf
bash install --xdg --key-bindings --completion --update-rc
rm ~/.zshrc
