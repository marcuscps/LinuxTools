#!/bin/bash

EXPECTED=IMultimedia
PROJ_NAME=$1
if [ ! "${PROJ_NAME}" == "${EXPECTED}" ]; then
	echo -e "${CCYAN}Invalid Project Name: Give: ${CYELLOW}${PROJ_NAME} ${CCYAN}, expected: ${CYELLOW}${EXPECTED}${CEND}"
	exit
fi

export PROJ_BASE_DIR=~/src/${PROJ_NAME}
echo -e "    ${CLPURPLE}Base dir: ${CYELLOW}${PROJ_BASE_DIR}${CEND}"
echo -e "    ${CLPURPLE}Nothing else to do.${CEND}"

