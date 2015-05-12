#/bin/bash

cp ~/SetEnv.sh ./
cp -r ~/MVNEnv ./
rm -f ./MVNEnv/Projs/{ICache.h,IMultimedia.sh,Security.sh,Tizen.sh,Default}
ln -sf Study.sh ./MVNEnv/Projs/Default
cp -r ~/cscope ./
rm -rf ./cscope/indexes/*
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc
cp ~/.gitconfig ./Gitconfig
cp ~/.inputrc ./Inputrc

