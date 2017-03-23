#!/bin/bash

_SetEnvSh()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(find "${ENV_DIR}"/Projs/ -mindepth 1 -printf "%P\n" | cut -d'.' -f1)" -X Default -- "$cur") )
}
complete -F _SetEnvSh SetEnv.sh

