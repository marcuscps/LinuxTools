#!/bin/bash

. ~/Scripts/defineColors.sh

for iii in `find ./ -name bin -o -name .bin.debug`; do
	rm ${iii}
	if [ "$?" == "0" ]; then
		echo -e "    ${CGREEN}deleted: ${CLPURPLE}${iii}${CEND}"
	else
		echo -e "    ${CYELLOW}DELETE FAILED: ${CLPURPLE}${iii}${CEND}"
	fi
done

echo -e "${CYELLOW}Done.${CEND}"

