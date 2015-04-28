#!/bin/bash

. ~/Scripts/defineColors.sh

ME=`basename $0`

# Options
num=1
memTest=0
diffIgnoreS="-Z"
diffOptions="-y -s"

# Command line options
while getopts ":mflz" arg; do
	case $arg in
		m)
			memTest=1
			;;
		f)
			memTest=1;
			memTestOpts="--leak-check=full"
			buildOpts="-g"
			;;
		l)
			memTest=1;
			memTestOpts="--leak-check=full --show-leak-kinds=all"
			buildOpts="-g"
			;;
		z)
			diffIgnoreS=
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo >&2
			echo "Syntax: $ME <options> [test number]" >&2
			echo -e "\tOptions:" >&2
			echo -e "\t\t -m\t Enable basic memory leak check (valgrind)" >&2
			echo -e "\t\t -f\t Enable full memory leak check (valgrind)" >&2
			echo -e "\t\t -f\t Enable full memory leak check with complete leak report (valgrind)" >&2
			echo -e "\t\t -z\t Do NOT ignore trailling spaces (white spaces at line end) in the output" >&2
			echo >&2
			echo -e "\tTest number defaults to 1" >&2
			exit 1
			;;
		:)  echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done
shift $((OPTIND-1))

# Test number
if [ $# -ge 1 ]; then
	num=$1
fi

# Check binary is found (compile it otherwise)
# Also checks whether debug info is necessary and/or desired.
if [ -f ./bin ]; then
	if [ "${memTest}" == "1" ]; then
		if [ ! -f ./.bin.debug ]; then
			echo -e "${CCYAN}Debug info required. ${CYELLOW}Forcing rebuild.${CEND}"
			buildRequired=1
		fi
	else
		if [ -f ./.bin.debug ]; then
			echo -e "${CCYAN}Debug info not desired. ${CYELLOW}Forcing rebuild.${CEND}"
			buildRequired=1
		fi
	fi
else
	buildRequired=1
fi

if [ "${buildRequired}" == "1" ]; then
	${SD}/Compile.sh ${buildOpts}
	if [ "$?" != "0" ]; then
		exit 2
	fi
fi

# Check input file
if [ ! -f input${num}.txt ]; then
	echo -e "${CLRED}Input file   ${CYELLOW}input${num}.txt${CLRED}   not found.${CEND}"
	exit 3
fi

# Run it measuring execution time
startTS=`date +%s%N | cut -b1-13`
if [ "${memTest}" == "1" ]; then
	cat input${num}.txt | grep -v "^##" | valgrind --tool=memcheck ${memTestOpts} ./bin > .tmp
else
	cat input${num}.txt | grep -v "^##" | ./bin > .tmp
fi
if [ "$?" != "0" ]; then
	exit 1
fi
endTS=`date +%s%N | cut -b1-13`

# Post processing output (remove comments and debug info)
grep -v "^##" .tmp > .tmp2
# Pre processing expected output (remove comments)
grep -v "^##" output${num}.txt > .tmp4

diffOptions="${diffOptions} ${diffIgnoreS}"
diff .tmp4 .tmp2 ${diffOptions} > .tmp3

if [ "$?" != "0" ]; then
	echo -e "${CLRED}TEST FAILED!!${CEND}"
	echo -e "${CYELLOW}==================================== ${CLRED}DIFF${CYELLOW} ====================================${CEND}"
	cat .tmp3
	echo -e "${CYELLOW}=================================== ${CLRED}OUTPUT${CYELLOW} ===================================${CEND}"
	cat .tmp
	echo -e "${CYELLOW}==============================================================================${CEND}"
	echo -e "${CLRED}TEST FAILED!! Check diff above!${CEND}"
else
	colorOutput=${CGREEN}
	echo -e "${CGREEN}TEST PASSED!${CEND}"
	echo -e "${CYELLOW}=================================== ${CGREEN}OUTPUT${CYELLOW} ===================================${CEND}"
	cat .tmp
	echo -e "${CYELLOW}==============================================================================${CEND}"
	echo -e "${CGREEN}TEST PASSED!${CEND}"
fi

echo -e "${CCYAN}Runtime: ${CYELLOW}$(( (endTS - startTS) )) uSeconds${CEND}"

# Clean up
rm .tmp .tmp2 .tmp3 .tmp4

echo -e "${CYELLOW}Done.${CEND}"

