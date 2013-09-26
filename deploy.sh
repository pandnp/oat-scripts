#!/bin/sh

OAT=$1
GLASSFISH_HOME=$2

# deploy the web services
echo "deploy the web services"
cd $GLASSFISH_HOME/domains/domain1/autodeploy
cp $OAT/trust-agent/HisPrivacyCAWebServices2/target/HisPrivacyCAWebServices2.war HisPrivacyCAWebServices2.war
cp $OAT/services/WLMService/target/WLMService-1.2-SNAPSHOT-core.war WLMService.war
cp $OAT/portals/WhiteListPortal/target/WhiteListPortal-1.2-SNAPSHOT-core.war WhiteListPortal.war
cp $OAT/services/AttestationService/target/AttestationService-1.2-SNAPSHOT-core.war AttestationService.war
cp $OAT/portals/TrustDashBoard/target/TrustDashBoard-1.2-SNAPSHOT-core.war TrustDashBoard.war

$GLASSFISH_HOME/bin/asadmin restart-domain domain1
$GLASSFISH_HOME/bin/asadmin deploy HisPrivacyCAWebServices2.war
$GLASSFISH_HOME/bin/asadmin deploy WLMService.war
$GLASSFISH_HOME/bin/asadmin deploy WhiteListPortal.war
$GLASSFISH_HOME/bin/asadmin deploy AttestationService.war
$GLASSFISH_HOME/bin/asadmin deploy TrustDashBoard.war
