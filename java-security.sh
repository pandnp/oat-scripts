#!/bin/sh

export JAVA_SECURITY=/usr/lib/jvm/java-7-openjdk-amd64

PROVIDER_9="^security.provider.9=.*"
PROVIDER_10="security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider"
FILE=$JAVA_HOME/jre/lib/security/java.security

if !( grep -Fxq $PROVIDER_10 $FILE ) then
  sed -i "s/$PROVIDER_9/&\n$PROVIDER_10/g" $FILE
fi
