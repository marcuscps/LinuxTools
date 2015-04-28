#!/bin/bash

. ~/Scripts/defineColors.sh

ME=`basename $0`

mode="prod"
buildRequired=0

# Command line options
while getopts ":gf" arg; do
	case $arg in
		g)
			mode="debug"
			debugOpts="-g -ggdb"
			;;
		f)
			echo -e "${CYELLOW}Forcing rebuild.${CEND}"
			buildRequired=1
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo >&2
			echo "Syntax: $ME <options>" >&2
			echo -e "\tOptions:" >&2
			echo -e "\t\t -g\t Enable debugging." >&2
			exit 1
			;;
		:)  echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

function is_build_required {
	local __resultVar=$1
	local mode=$2

	# Check binary is found
	if [ ! -f ./bin ]; then
		echo -e "${CCYANlll}Binary not found. ${CYELLOW}Forcing rebuild.${CEND}"
		eval $__resultVar=1
		return 1
	fi

	# Checks whether debug info is necessary and/or desired.
	if [ "${mode}" == "debug" ]; then
		if [ ! -f ./.bin.debug ]; then
			echo -e "${CCYANlll}Debug info required. ${CYELLOW}Forcing rebuild.${CEND}"
			eval $__resultVar=1
			return 1
		fi
	else
		if [ -f ./.bin.debug ]; then
			echo -e "${CCYAN}Debug info not desired. ${CYELLOW}Forcing rebuild.${CEND}"
			eval $__resultVar=1
			return 1
		fi
	fi

	# Check file time stamps against binary time stamp.
	binTS=`stat -c%Y bin`
	for iii in `ls *.cpp`; do
		srcTS=`stat -c%Y ${iii}`
		if [ ${srcTS} -gt ${binTS} ]; then
			echo -e "${CCYAN}Source file ${CLGREEN}${iii} ${CCYAN}updated. ${CYELLOW}Forcing rebuild.${CEND}"
			eval $__resultVar=1
			return 1
		fi
	done

	eval $__resultVar=0
	return 0
}


if [ "${buildRequired}" == "0" ]; then
	is_build_required buildRequired ${mode}
fi

if [ "${buildRequired}" == "1" ]; then
	if [ "${mode}" == "debug" ]; then
		touch .bin.debug
	else
		rm .bin.debug -f
	fi

	echo -e "${CCYAN}Building...${CEND}"
	g++ -Wall -pedantic -o bin *.cpp -std=c++11 ${debugOpts}

	if [ "$?" == "0" ]; then
		echo -e "${CYELLOW}Done.${CEND}"
	else
		echo -e "${CRED}Error(s) found.${CEND}"
	fi
else
	echo -e "${CYELLOW}Build skipped.${CEND}"
fi

