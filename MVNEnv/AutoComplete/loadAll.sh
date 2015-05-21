#!/bin/bash

for iii in `find ${ENV_DIR}/AutoComplete/ -type f | grep -v loadAll`; do
	source $iii
done

