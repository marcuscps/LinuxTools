#!/bin/bash

. ~/Scripts/defineColors.sh

ME=`basename $0`

if [ "$#" -lt "1" ]; then
	echo -e "${CLRED}ERROR: Missing problem name.${CEND}"
	echo -e "${CWHITE}Syntax:${CEND}"
	echo -e "\t${CYELLOW}${ME} ${CGREEN}<problem name>${CEND}"
	exit 1
fi

inputs=1
if [ "$#" -ge "2" ]; then
	inputs=$2
fi

if [ -d $1 ]; then
	echo -e "${CLRED}ERROR: Project directory already found.${CEND}"
	exit 1
fi

echo -e "${CWHITE}Test cases: ${CGREEN}${inputs}${CEND}"

cp -a ${SD}/../TEMPLATE $1
mv $1/TEMPLATE.cpp $1/$1.cpp
cd $1

for iii in `seq 1 ${inputs}`; do
	testFiles="${testFiles} input${iii}.txt output${iii}.txt"
done

touch ${testFiles}
${EDITOR} $1.cpp ${testFiles}

echo -e "${CYELLOW}Done.${CEND}"

