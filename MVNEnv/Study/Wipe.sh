#!/bin/bash

find ./ -name bin -o -name .bin.debug -o -name .tmp -o -name .tmp2 | while read -r iii; do
	rm "${iii}"
	if [ "$?" == "0" ]; then
		echo -e "    ${CGREEN}deleted: ${CLPURPLE}${iii}${CEND}"
	else
		echo -e "    ${CYELLOW}DELETE FAILED: ${CLPURPLE}${iii}${CEND}"
	fi
done

echo -e "${CYELLOW}Done.${CEND}"

