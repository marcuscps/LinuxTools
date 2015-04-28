#!/bin/bash

# Configuration
DEFAULT_PROJ_FILE=`readlink ~/Scripts/Projs/Default`
DEFAULT_PROJ=${DEFAULT_PROJ_FILE/.sh/}

#==============================================================================
#= Pre configuration
#==============================================================================
. ~/Scripts/defineColors.sh

echo -e "${CWHITE}Configuring ${CYELLOW}Samsung ${CWHITE}environment ${CYELLOW}(by Marcus)${CWHITE}...${CEND}"

# Default project
PROJ_NAME=$1
if [ "${PROJ_NAME}" == "" ]; then
	echo -e "${CCYAN}Using default droject: ${CYELLOW}${DEFAULT_PROJ}${CEND}"
	PROJ_NAME=${DEFAULT_PROJ}
fi

echo -e "Searching for project configuration file: ${CCYAN}~/Scripts/Projs/${PROJ_NAME}.sh${CEND}"
if [ ! -f ~/Scripts/Projs/${PROJ_NAME}.sh ]; then
	echo -e "    ${CLRED}FAIL.${CEND}"
	echo -e "${CLRED}Invalid project name. Aborting (no side effects)...${CEND}"
	echo -e "${CCYAN}Available projects:${CEND}"
	for ii in `ls ~/Scripts/Projs`; do
		echo -e "\t${CYELLOW}${ii%.sh}${CEND}"
	done
	echo -e "${CWHITE}Done!${CEND}"
	return 1
fi

#==============================================================================
#= General Configuration
#==============================================================================
echo -e "${CCYAN}General configuration:${CEND}"
echo -e "    ${CLPURPLE}NONE.${CEND}"

#==============================================================================
#= Project specific configuration
#==============================================================================
echo -e "${CCYAN}Project (${CYELLOW}${PROJ_NAME}${CCYAN}) specific configuration:${CEND}"
source ~/Scripts/Projs/${PROJ_NAME}.sh ${PROJ_NAME}

#==============================================================================
#= Configuring CSCOPE
#==============================================================================
echo -e "${CCYAN}Configuring CSCOPE:"
CSCOPE_DB=~/cscope/indexes/${PROJ_NAME}/cscope.out
echo -e "    ${CLPURPLE}DB Location: ${CYELLOW}${CSCOPE_DB}${CEND}"


#==============================================================================
#= Global EXPORTS
#==============================================================================
echo -e "${CCYAN}Exporting environment variables...${CEND}"
export CSCOPE_DB
export PROJ_NAME
export PROJ_BASE_DIR

echo -e "${CCYAN}Switching to project base dir...${CEND}"
cd ${PROJ_BASE_DIR}

echo -e "${CWHITE}Done!${CEND}"

