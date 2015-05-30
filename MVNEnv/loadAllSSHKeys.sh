#!/bin/bash

for iii in `find ~/.ssh/id* -type f | grep -v "\.pub"`; do
	ssh-add $iii
done

