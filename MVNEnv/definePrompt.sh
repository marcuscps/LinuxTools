#!/bin/bash

if [ "${EUID}" = "0" ]; then
	FCOLOR="\[${CRED}\]"
	UINFO=
	ESIGN="${FCOLOR}#"
else
	FCOLOR="\[${CLBLUE}\]"
	UINFO="${FCOLOR}-[\[${CCYAN}\]\u${FCOLOR}]"
	ESIGN="${FCOLOR}$"
fi

FAIL_SIGN="\[${CRED}\]\342\234\227"

export PS1="${FCOLOR}\$([[ \$? != 0 ]] && echo \"[${FAIL_SIGN}${FCOLOR}]-\")[\[${CPURPLE}\]\A${FCOLOR}]-[\[${CYELLOW}\]\h${FCOLOR}]${UINFO}-[\[${CPURPLE}\]\$(_dotfiles_scm_info %s)${FCOLOR}] \[${CGREEN}\]\W ${ESIGN}\[${CEND}\] "
export PS2="${FCOLOR}> \[${CEND}\]"

unset FAIL_SIGN
unset ESIGN
unset UINFO
unset FCOLOR
