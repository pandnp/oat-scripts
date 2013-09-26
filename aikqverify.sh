#!/bin/sh

OAT=$1

# install aikqverify
echo "install aikqverify"
cd $HOME
rm -rf aikqverify*
cp $OAT/services/aikqverify/target/aikqverify-2.0.zip $HOME
unzip aikqverify-2.0.zip
cd aikqverify-2.0
make
make install
