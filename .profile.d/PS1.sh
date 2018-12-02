# Normal
Yellow='\[\e[33m\]'
Sky='\[\e[36m\]'

# Bold
BRed='\[\e[1;31m\]'
BYellow='\[\e[1;33m\]'
BSky='\[\e[1;36m\]'
Reset='\[\e[0m\]'


PS1="${BSky}\u${Reset}"
PS1+="${BRed}@${Reset}"
PS1+="${BYellow}\h${Reset} "
PS1+="\W"
PS1+="${BYellow}\$(__git_ps1)${Reset} "
PS1+="${Sky}[${AWS_PROFILE:-none}]${Reset} "
PS1+="${BRed}[${Reset}"
PS1+="\d"
PS1+="${BRed}|${Reset}"
PS1+="\t"
PS1+="${BRed}]${Reset}"
PS1+="\n"
PS1+="${BSky}(*'-')${Reset} "
PS1+="${BRed}<${Reset}"
PS1+="${BYellow}<${Reset}"
PS1+="${BSky}<${Reset} "
