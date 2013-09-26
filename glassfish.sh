#!/bin/sh
OAT=
OAT_JARS=$OAT/trust-agent/TrustAgent/target/jars
OAT_LIB=$OAT/trust-agent/HisPrivacyCAWebServices2/target/WEB-INF/lib
PORTALS_LIB=$OAT/portals/TrustDashBoard/target/TrustDashBoard-1.2-SNAPSHOT/WEB-INF/lib
GLASSFISH_HOME=$HOME/glassfish3/glassfish

cd $HOME
wget http://download.java.net/glassfish/v3/release/glassfish-v3.zip
unzip glassfish-v3.zip

# jackson-core-asl-1.9.11.jar   
# jackson-jaxrs-1.9.11.jar
# jackson-mapper-asl-1.9.11.jar
# jackson-xc-1.9.11.jar
cp $OAT_JARS/jackson*.jar $GLASSFISH_HOME/modules
cp $PORTALS_LIB/jackson-xc*.jar $GLASSFISH_HOME/modules

#javax.servlet-api.jar
#javax.annotation-3.1.1.jar
#javax.annotation.jar
cp $OAT_JARS/javax.servlet*.jar $GLASSFISH_HOME/modules

#jaxws-api.jar
#jaxws-rt.jar
#jaxws-tools.jar
cp $OAT_LIB/jaxws*.jar $GLASSFISH_HOME/modules

#jaxb-api-osgi.jar
#jaxb-impl-2.1.9.jar
#jaxb-api-2.1.jar
#jaxb-xjc.jar
cp $OAT_LIB/jaxb*.jar $GLASSFISH_HOME/modules

#jsr181-api.jar
#jsr311-api-1.1.1.jar
cp $OAT_LIB/jsr181*.jar $GLASSFISH_HOME/modules
cp $PORTALS_LIB/jsr311*.jar $GLASSFISH_HOME/modules

#streambuffer.jar
#stax-ex.jar
#servlet-api.jar
#mysql-connector-java-5.1.22.jar
#webservices-api-osgi.jar
cp $OAT_LIB/streambuffer*.jar $GLASSFISH_HOME/modules
cp $OAT_LIB/stax*.jar $GLASSFISH_HOME/modules
cp $OAT_LIB/servlet*.jar $GLASSFISH_HOME/modules
cp $PORTALS_LIB/mysql-connector*.jar $GLASSFISH_HOME/modules
