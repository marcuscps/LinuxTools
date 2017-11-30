#!/bin/bash

for iii in $(find "${ENV_DIR}"/AutoComplete/ -type f -executable | grep -v loadAll); do
	source "$iii"
done

