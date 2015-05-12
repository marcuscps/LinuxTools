#/bin/bash

cp ~/SetEnv.sh ./
cp -r ~/MVNEnv ./
ln -sf Study.sh ./MVNEnv/Projs/Default
cp -r ~/cscope ./
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc
cp ~/.gitconfig ./Gitconfig
cp ~/.inputrc ./Inputrc

# Using personal email
sed -i s/m.vinicius@samsung.com/marcus.cps@gmail.com/ Gitconfig

# Removing copyrighted projects
rm -f ./MVNEnv/Projs/{ICache.h,IMultimedia.sh,Security.sh,Tizen.sh,Default}
# Removing cscope indexes.
rm -rf ./cscope/indexes/*
# Removing backup files
find ./ -name *~ -exec rm {} \;

