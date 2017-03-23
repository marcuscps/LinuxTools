#!/bin/bash

sudo apt-get install golang fuse git-core libmtp-dev libfuse-dev
sudo adduser "$USER" fuse
mkdir /tmp/go 
GOPATH=/tmp/go go get github.com/hanwen/go-mtpfs
sudo mv /tmp/go/bin/go-mtpfs /usr/bin/
mkdir ~/MyAndroid

