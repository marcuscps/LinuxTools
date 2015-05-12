#!/bin/bash

. ~/MVNEnv/defineColors.sh

EXPECTED=Tizen
PROJ_NAME=$1
if [ ! "${PROJ_NAME}" == "${EXPECTED}" ]; then
	echo -e "${CCYAN}Invalid Project Name: Give: ${CYELLOW}${PROJ_NAME} ${CCYAN}, expected: ${CYELLOW}${EXPECTED}${CEND}"
	exit
fi

export PROJ_BASE_DIR=~/src/${PROJ_NAME}
echo -e "    ${CLPURPLE}Base dir:  ${CYELLOW}${PROJ_BASE_DIR}${CEND}"

export TOP_DIR=${PROJ_BASE_DIR}
echo -e "    ${CLPURPLE}TOP_DIR:   ${CYELLOW}${TOP_DIR}${CEND}"
export SEC_DIR=${PROJ_BASE_DIR}/Platform/Security/openssl
echo -e "    ${CLPURPLE}SEC_DIR:   ${CYELLOW}${SEC_DIR}${CEND}"
export LUA_DIR=${PROJ_BASE_DIR}/Core/MediaPlayers/Lua/LuaAPI
echo -e "    ${CLPURPLE}LUA_DIR:   ${CYELLOW}${LUA_DIR}${CEND}"
export TEST_DIR=~/Testes\ -\ Security\ \(entrega\ #112\)
echo -e "    ${CLPURPLE}TEST_DIR:  ${CYELLOW}${TEST_DIR}${CEND}"

export SD=~/MVNEnv/Tizen/
export PATH=${PATH}:$SD

echo -e "    ${CLPURPLE}SD:        ${CYELLOW}${SD}${CEND}"
echo -e "    ${CLPURPLE}PATH:      ${CYELLOW}${PATH}${CEND}"

echo -e "    ${CLPURPLE}Nothing else to do.${CEND}"

