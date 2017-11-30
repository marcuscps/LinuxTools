#!/bin/bash

__fzf_select_from_tmux_pane ()
{
	builtin typeset READLINE_LINE_NEW="$(
	command tmux capture-pane -Jp   \
		| command sed 's/\s/\n/g' \
		| sort \
		| uniq \
		| env fzf -m
	)"

	if
		[[ -n $READLINE_LINE_NEW ]]
	then
		builtin bind '"\er": redraw-current-line'
		builtin bind '"\e^": magic-space'
		READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
		READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
	else
		builtin bind '"\er":'
		builtin bind '"\e^":'
	fi
}

builtin bind -x '"\C-x1": __fzf_select_from_tmux_pane'
builtin bind '"\C-]": "\C-x1\e^\er"'

