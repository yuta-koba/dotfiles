#!/bin/bash

# Normal {{{
_Sky='\[\e[36m\]'
# }}}

# Bold {{{
_BRed='\[\e[1;31m\]'
_BYellow='\[\e[1;33m\]'
_BSky='\[\e[1;36m\]'
_Reset='\[\e[0m\]'
# }}}

# PS {{{
PS1="${_BSky}\u${_Reset}"
PS1+="${_BRed}@${_Reset}"
PS1+="${_BYellow}\h${_Reset} "
PS1+="\W"
PS1+="${_BYellow}\$(__git_ps1)${_Reset} "
PS1+="${_Sky}[${AWS_PROFILE:-none}]${_Reset} "
PS1+="${_BRed}[${_Reset}"
PS1+="\d"
PS1+="${_BRed}|${_Reset}"
PS1+="\t"
PS1+="${_BRed}]${_Reset}"
PS1+="\n"
PS1+="${_BSky}(*'-')${_Reset} "
PS1+="${_BRed}<${_Reset}"
PS1+="${_BYellow}<${_Reset}"
PS1+="${_BSky}<${_Reset} "
# }}}
