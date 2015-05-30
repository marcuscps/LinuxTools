#/bin/bash

mkdir work
cd work

for iii in `ls ../ | grep -v work`; do
	cp -r ../${iii} ./
done


mv Gitconfig .gitconfig
mv Inputrc .inputrc
mv Vim .vim
mv Vimrc .vimrc

