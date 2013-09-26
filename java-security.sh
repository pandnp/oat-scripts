#!/bin/sh

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

PROVIDER_9="^security.provider.9=.*"
PROVIDER_10="security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider"
FILE=$JAVA_HOME/jre/lib/security/java.security

if !( grep -Fxq $PROVIDER_10 $FILE ) then
  sed -i "s/$PROVIDER_9/&\n$PROVIDER_10/g" $FILE
fi

cd $HOME
wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" http://download.oracle.com/otn-pub/java/jce_policy/6/jce_policy-6.zip
unzip jce_policy-6.zip
cp jce/*.jar $JAVA_HOME/jre/lib/security
