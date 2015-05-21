_setenv()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(ls ${ENV_DIR}/Projs/ | cut -d'.' -f1)" -X Default -- $cur) )
}
complete -F _setenv SetEnv.sh
