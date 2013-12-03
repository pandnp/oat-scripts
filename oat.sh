#!/bin/sh

#if [ $# -ne 4]; then
#	echo "Usage `basename $0` {user} {server-ip} {path/to/OpenAttestation}"
#	exit 65 # E_BADARGS
#fi

HOST=`/bin/hostname`
GLASSFISH_HOME=$HOME/glassfish3/glassfish
USER=$1
IP=$2
OAT=$3

sh java-security.sh
sh mysql.sh "$OAT"
sh glassfish.sh "$OAT"
sh config.sh "$IP" "$USER"
sh aikqverify.sh "$OAT"
sh keytool.sh "$OAT" "$GLASSFISH_HOME" "$HOST" "$USER"
sh deploy.sh "$OAT" "$GLASSFISH_HOME"
