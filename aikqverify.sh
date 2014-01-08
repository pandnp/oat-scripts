#!/bin/sh

OAT=$1

# install aikqverify
echo "install aikqverify"
cd $HOME
cp $OAT/services/aikqverify/target/aikqverify-*.zip $HOME
unzip aikqverify-*.zip
cd aikqverify-*
make
make install
