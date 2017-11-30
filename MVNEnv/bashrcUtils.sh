#!/bin/bash

# Alias to clear terminal (including all history)
# use it together with .inputrc file.
# So you can map it to ^K, for instance
alias clearx='echo -en \\033c'
bind -x '"\C-K": "clearx"'

# allow ^S to forward search (like ^R does in reverse).
stty stop undef

export ENV_DIR=~/MVNEnv
# export SSH_ASKPASS=ssh-askpass

source "${ENV_DIR}/defineColors.sh"
source "${ENV_DIR}/definePrompt.sh"
source "${ENV_DIR}/AutoComplete/loadAll.sh"

# ssh-agent
# eval $(ssh-agent) > /dev/null
# source ${ENV_DIR}/loadAllSSHKeys.sh

# Activate LS colors
export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# General aliases
alias ..='cd ..'
alias la="ls -a"
alias ll="ls -l"

# Git aliases
alias Git-gc-all="git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 -c gc.rerereunresolved=0 -c gc.pruneExpire=now gc --aggressive"

# Git config
export LESS=${LESS}R

# Load tmux automatically on login
if [ "$TERM" != "nuclide" ] && [ -t 0 ] && [ -z "$TMUX" ] && which tmux >/dev/null 2>&1 && [[ "$(tmux -V)" == "tmux 1.8" || "$(tmux -V)" == "tmux 2.2" ]]; then
	if tmux has-session -t auto >/dev/null 2>&1; then
		tmux -2CC attach-session -t auto
	else
		tmux -2CC new-session -s auto
	fi
fi

