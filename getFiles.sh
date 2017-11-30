#/bin/bash

rm -rf ./Vim ./Vimrc

cp ~/SetEnv.sh ./
cp -r ~/MVNEnv ./
cp -r ~/.vim ./Vim
cp ~/.vimrc ./Vimrc
cp ~/.inputrc ./Inputrc

cp ~/.gitconfig ./Gitconfig
# Removing email
sed -i '/email = /d' Gitconfig

ln -sf Study.sh ./MVNEnv/Projs/Default
# Removing copyrighted projects
cd MVNEnv/Projs/
find . ! -path . | grep -vFf preserveProjs.txt > /tmp/MVNEnvProjsDelete
xargs rm < /tmp/MVNEnvProjsDelete
cd -

if [ -f ~/cscope ]; then
	cp -r ~/cscope ./
	# Removing cscope indexes.
	rm -rf ./cscope/indexes/*
fi

# Removing backup files
find ./ -name *~ -exec rm {} +
