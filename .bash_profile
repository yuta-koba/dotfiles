if [ -e ~/.bashrc ];then
    source ~/.bashrc
fi

declare script_dir=( "${HOME}/.profile.d" "/usr/local/etc/bash_completion.d" )
for d in ${script_dir[@]};do
  for f in $(ls ${d});do
    source $d/$f
  done
done

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export EDITOR=nvim
