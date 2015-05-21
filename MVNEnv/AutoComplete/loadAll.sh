#!/bin/bash

for iii in `ls ${ENV_DIR}/AutoComplete/ | grep -v loadAll`; do
	source ${ENV_DIR}/AutoComplete/$iii
done

