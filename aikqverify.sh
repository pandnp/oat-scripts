#!/bin/sh

OAT=$1

# install aikqverify
echo "install aikqverify"
cd $HOME
if [ ! -e aikqverify-2.0 ]; then
  cp $OAT/services/aikqverify/target/aikqverify-2.0.zip $HOME
  unzip aikqverify-2.0.zip
fi
cd aikqverify-2.0
make
make install
