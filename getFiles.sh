#/bin/bash

cp -r ~/cscope ./
rm -rf ./cscope/indexes/*
cp ~/.gitconfig ./Gitconfig
cp ~/.inputrc ./Inputrc
cp -r ~/Scripts ./
cp ~/SetEnv.sh ./
mkdir -p Study
cp -r ~/src/Study/Scripts ./Study/
cp -r ~/src/Study/TEMPLATE ./Study/
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc

