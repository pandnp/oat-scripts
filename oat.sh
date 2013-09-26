#!/bin/sh

HOST=`/bin/hostname`
USER=fin
IP=192.168.1.1
OAT=/root/home
GLASSFISH_HOME=/root/home/glasfish3/glassfish

sh mysql.sh $OAT
sh glassfish $OAT
sh config.sh $HOST $IP
sh aikqverify.sh $OAT
sh keytool.sh $OAT $GLASSFISH_HOME $IP $USER
sh deploy.sh $OAT $GLASSFISH_HOME
