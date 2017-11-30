#!/bin/bash

function usage {
	cat <<EOM
	Usage:
	$(basename $0) <revision> [revisions]

	Rebases all branches on master.
EOM
	exit 1
}

if [ -z $1 ]; then
	usage
fi

for iii in $*; do
	echo -e "${CCYAN}Rebasing ${CYELLOW}$iii ${CCYAN}on ${CYELLOW}master ${CCYAN}...${CEND}"
	hg rebase -s $iii -d master
done

