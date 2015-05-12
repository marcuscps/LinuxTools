#!/bin/bash

. ~/MVNEnv/defineColors.sh

ME=`basename $0`

num=001
suf=00001

if [ $# -ge 1 ]; then
	num=$1
fi

if [ $# -ge 2 ]; then
	suf=$2
fi

cd ~/NCLEmulator
./emulator "${TEST_DIR}/Test_behavioral_event_TA-${num}_${suf}/tmpData/tests/" Test_behavioral_event_TA-${num}_${suf}.ncl

echo -e "${CYELLOW}Done.${CEND}"

