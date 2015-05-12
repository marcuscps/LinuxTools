#!/bin/bash

EXPECTED=LDD3
PROJ_NAME=$1
if [ ! "${PROJ_NAME}" == "${EXPECTED}" ]; then
	echo -e "${CCYAN}Invalid Project Name: Give: ${CYELLOW}${PROJ_NAME} ${CCYAN}, expected: ${CYELLOW}${EXPECTED}${CEND}"
	exit
fi

export PROJ_BASE_DIR=~/kernel/
echo -e "    ${CLPURPLE}Base dir: ${CYELLOW}${PROJ_BASE_DIR}${CEND}"
export KERNELDIR=~/kernel/linux-3.11.3/
echo -e "    ${CLPURPLE}Kernel dir: ${CYELLOW}${KERNELDIR}${CEND}"
echo -e "    ${CLPURPLE}Nothing else to do.${CEND}"

