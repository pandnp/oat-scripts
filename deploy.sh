#!/bin/sh

OAT=$1
GLASSFISH_HOME=$2

# deploy the web services
echo "deploy the web services"
cd $GLASSFISH_HOME/domains/domain1/autodeploy
cp $OAT/trust-agent/HisPrivacyCAWebServices2/target/HisPrivacyCAWebServices2.war HisPrivacyCAWebServices2.war
cp $OAT/services/WLMService/target/WLMService-*-core.war WLMService.war
cp $OAT/portals/WhiteListPortal/target/WhiteListPortal-*-core.war WhiteListPortal.war
cp $OAT/services/AttestationService/target/AttestationService-*-core.war AttestationService.war
cp $OAT/portals/TrustDashBoard/target/TrustDashBoard-*-core.war TrustDashBoard.war
