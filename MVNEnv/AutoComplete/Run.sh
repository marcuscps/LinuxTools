#!/bin/bash

_runSh()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(find . -name 'input*.txt' -exec basename {} \; | cut -d'.' -f1 | sed 's/input//')" -- "$cur") )
}
complete -F _runSh Run.sh

