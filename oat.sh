#!/bin/sh

HOST=`/bin/hostname`
GLASSFISH_HOME=$HOME/glassfish3/glassfish
USER=$1
OAT=$2

sh java-security.sh
sh mysql.sh "$OAT"
sh glassfish.sh "$OAT"
sh config.sh "$USER"
sh aikqverify.sh "$OAT"
sh keytool.sh "$OAT" "$GLASSFISH_HOME" "$HOST" "$USER"
sh deploy.sh "$OAT" "$GLASSFISH_HOME"
