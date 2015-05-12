#/bin/bash

cp ~/SetEnv.sh ./
cp -r ~/MVNEnv ./
cp -r ~/cscope ./
rm -rf ./cscope/indexes/*
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc
cp ~/.gitconfig ./Gitconfig
cp ~/.inputrc ./Inputrc

