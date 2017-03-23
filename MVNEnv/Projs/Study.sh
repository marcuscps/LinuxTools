#!/bin/bash

EXPECTED=Study
PROJ_NAME=$1
if [ ! "${PROJ_NAME}" == "${EXPECTED}" ]; then
	echo -e "${CCYAN}Invalid Project Name: Give: ${CYELLOW}${PROJ_NAME} ${CCYAN}, expected: ${CYELLOW}${EXPECTED}${CEND}"
	exit
fi

export EDITOR=gvim
echo -e "    ${CLPURPLE}Editor:   ${CYELLOW}${EDITOR}${CEND}"

export PROJ_BASE_DIR=~/src/${PROJ_NAME}
echo -e "    ${CLPURPLE}Base dir: ${CYELLOW}${PROJ_BASE_DIR}${CEND}"

source "${ENV_DIR}/Projs/StudyCommon.sh"

echo -e "    ${CLPURPLE}Nothing else to do.${CEND}"

