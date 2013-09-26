#!/bin/sh

OAT=$1

# install aikqverify
echo "install aikqverify"
cd $HOME
rm -rf aikqverify*
cp $OAT/services/aikqverify/target/aikqverify-1.2-SNAPSHOT.zip $HOME
unzip aikqverify-1.2-SNAPSHOT.zip
cd aikqverify-1.2-SNAPSHOT
make
make install
