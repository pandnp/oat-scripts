#!/bin/sh
OAT=$1
OAT_JARS=$OAT/trust-agent/TrustAgent/target/jars
OAT_LIB=$OAT/trust-agent/HisPrivacyCAWebServices2/target/WEB-INF/lib
PORTALS_LIB=$OAT/portals/TrustDashBoard/target/TrustDashBoard-*/WEB-INF/lib
GLASSFISH_HOME=$HOME/glassfish3/glassfish

cd $HOME
if [ ! -e glassfish3 ]; then
  wget http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip
  unzip glassfish-3.1.2.2.zip
fi

cp $OAT_JARS/jackson*.jar $GLASSFISH_HOME/modules
cp $PORTALS_LIB/jackson-xc*.jar $GLASSFISH_HOME/modules
