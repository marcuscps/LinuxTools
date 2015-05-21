_runSh()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(ls input*.txt 2>/dev/null | cut -d'.' -f1 | sed -e 's/input//')" -- $cur) )
}
complete -F _runSh Run.sh

