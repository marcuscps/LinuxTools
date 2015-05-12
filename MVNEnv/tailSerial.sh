#!/bin/bash

if [ "$1" == "-c" ]; then
	DELETE_LOGFILE=1
	shift
fi

FNAME=$1

if [ "${FNAME}" == "" ]; then
	FNAME=minicom.cap
fi

if [ "${DELETE_LOGFILE}" == "1" ]; then
	echo "Deleting log file ${FNAME} ..."
	echo "" > ${FNAME}
fi

echo "Showing continuous logs from the file ${FNAME} ..."
echo

tail -f ${FNAME} | while read; do echo "$(date +%T.%N) $REPLY"; done

