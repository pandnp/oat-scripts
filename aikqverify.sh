#!/bin/sh

OAT=$1

# install aikqverify
echo "install aikqverify"
cd $HOME
if [ ! -e aikqverify-2.0 ]; then
  cp $OAT/services/aikqverify/target/aikqverify-*.zip $HOME
  unzip aikqverify-*.zip
fi
cd aikqverify-*
make
make install
