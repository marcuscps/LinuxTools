#!/bin/bash

. ~/Scripts/defineColors.sh

export SD=`dirname ${BASH_SOURCE} | xargs readlink -f`
export PATH=${PATH}:$SD

echo -e "    ${CLPURPLE}SD:       ${CYELLOW}${SD}${CEND}"
echo -e "    ${CLPURPLE}PATH:     ${CYELLOW}${PATH}${CEND}"

