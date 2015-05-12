#/bin/bash

cp -r ~/cscope ./
rm -rf ./cscope/indexes/*
cp ~/.gitconfig ./Gitconfig
cp ~/.inputrc ./Inputrc
cp -r ~/MVNEnv ./
cp ~/SetEnv.sh ./
mkdir -p Study
cp -r ~/src/Study ./Study/
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc

