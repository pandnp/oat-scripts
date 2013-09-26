#!/bin/sh

HOST=`/bin/hostname`
USER=
IP=
OAT=
GLASSFISH_HOME=

sh mysql.sh $OAT
sh config.sh $HOST $IP
sh aikqverify.sh $OAT
sh keytool.sh $OAT $GLASSFISH_HOME $IP $USER
sh deploy.sh $OAT $GLASSFISH_HOME
