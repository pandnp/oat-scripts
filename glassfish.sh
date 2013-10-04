#!/bin/sh
OAT=$1
OAT_JARS=$OAT/trust-agent/TrustAgent/target/jars
OAT_LIB=$OAT/trust-agent/HisPrivacyCAWebServices2/target/WEB-INF/lib
PORTALS_LIB=$OAT/portals/TrustDashBoard/target/TrustDashBoard-2.0/WEB-INF/lib
GLASSFISH_HOME=$HOME/glassfish3/glassfish

cd $HOME
if [ ! -e glassfish3 ]; then
  wget http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip
  unzip glassfish-3.1.2.2.zip
fi

# jackson-core-asl-1.9.11.jar   
# jackson-jaxrs-1.9.11.jar
# jackson-mapper-asl-1.9.11.jar
# jackson-xc-1.9.11.jar
cp $OAT_JARS/jackson*.jar $GLASSFISH_HOME/modules
cp $PORTALS_LIB/jackson-xc*.jar $GLASSFISH_HOME/modules
