#!/bin/sh

HOST=`/bin/hostname`
GLASSFISH_HOME=$HOME/glassfish3/glassfish
USER=$1
IP=$2
OAT=$3

sh java-security.sh
sh mysql.sh "$OAT"
sh glassfish.sh "$OAT"
sh config.sh "$IP"
sh aikqverify.sh "$OAT"
sh keytool.sh "$OAT" "$GLASSFISH_HOME" "$IP" "$USER"
sh deploy.sh "$OAT" "$GLASSFISH_HOME"
