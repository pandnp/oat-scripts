#!/bin/sh
HOSTNAME=`/bin/hostname`
PORTAL_USER=fin
SERVER_IP=9.41.149.106
OPEN_ATTESTATION=/home/fin/OpenAttestation
OAT_JARS=$OPEN_ATTESTATION/trust-agent/TrustAgent/target/jars
OAT_LIB=$OPEN_ATTESTATION/trust-agent/HisPrivacyCAWebServices2/target/WEB-INF/lib
PORTALS_LIB=$OPEN_ATTESTATION/portals/TrustDashBoard/target/TrustDashBoard-1.2-SNAPSHOT/WEB-INF/lib
CATALINA_HOME=/usr/share/tomcat6

OAT_DNAME="CN=AttestationService, OU=Security, O=LTC, C=US"
DNAME="OU=Security, O=LTC, C=US"
SERVER_DNAME="CN=$SERVER_IP, $DNAME"
PORTAL_DNAME="CN=$PORTAL_USER, $DNAME"

# vim /usr/share/tomcat6/bin/catalina.sh
# JAVA_OPTS=-Djava.endorsed.dirs=/usr/share/tomcat6/endorsed

if [ ! -e $CATALINA_HOME/endorsed ]; then
  mkdir $CATALINA_HOME/endorsed
fi

# jackson-core-asl-1.9.11.jar	
# jackson-jaxrs-1.9.11.jar
# jackson-mapper-asl-1.9.11.jar
# jackson-xc-1.9.11.jar
cp $OAT_JARS/jackson*.jar $CATALINA_HOME/endorsed
cp $PORTALS_LIB/jackson-xc*.jar $CATALINA_HOME/endorsed

#javax.servlet-api.jar
#javax.annotation-3.1.1.jar
#javax.annotation.jar
cp $OAT_JARS/javax.servlet*.jar $CATALINA_HOME/endorsed

#jaxws-api.jar
#jaxws-rt.jar
#jaxws-tools.jar
cp $OAT_LIB/jaxws*.jar $CATALINA_HOME/endorsed

#jaxb-api-osgi.jar
#jaxb-impl-2.1.9.jar
#jaxb-api-2.1.jar
#jaxb-xjc.jar
cp $OAT_LIB/jaxb*.jar $CATALINA_HOME/endorsed

#jsr181-api.jar
#jsr311-api-1.1.1.jar
cp $OAT_LIB/jsr181*.jar $CATALINA_HOME/endorsed
cp $PORTALS_LIB/jsr311*.jar $CATALINA_HOME/endorsed

#streambuffer.jar
#stax-ex.jar
#servlet-api.jar
#mysql-connector-java-5.1.22.jar
#webservices-api-osgi.jar
cp $OAT_LIB/streambuffer*.jar $CATALINA_HOME/endorsed
cp $OAT_LIB/stax*.jar $CATALINA_HOME/endorsed
cp $OAT_LIB/servlet*.jar $CATALINA_HOME/endorsed
cp $PORTALS_LIB/mysql-connector*.jar $CATALINA_HOME/endorsed

# modify tomcat configuration
echo "modify tomcat configuration"
sed -i "s/ <\/Service>/<Connector port=\"8181\" minSpareThreads=\"5\" maxSpareThreads=\"75\" enableLookups=\"false\" disableUploadTimeout=\"true\" acceptCount=\"100\" maxThreads=\"200\" scheme=\"https\" secure=\"true\" SSLEnabled=\"true\" clientAuth=\"want\" sslProtocol=\"TLS\" ciphers=\"TLS_ECDH_anon_WITH_AES_256_CBC_SHA, TLS_ECDH_anon_WITH_AES_128_CBC_SHA, TLS_ECDH_anon_WITH_3DES_EDE_CBC_SHA, TLS_ECDH_RSA_WITH_AES_256_CBC_SHA, TLS_ECDH_RSA_WITH_AES_128_CBC_SHA, TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA, TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA, TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA, TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA, TLS_DHE_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_DSS_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA, TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_128_CBC_SHA\" keystoreFile=\"Certificate\/keystore.jks\" keystorePass=\"changeit\" truststoreFile=\"Certificate\/keystore.jks\" truststorePass=\"changeit\" \/><\/Service>/g" /etc/tomcat6/server.xml

# database initialization
echo "database initialization"
if !(mysql -uroot -e 'use mw_as'); then
  mysql -uroot -e 'create database mw_as';
  mysql -uroot mw_as < $OPEN_ATTESTATION/database/mysql/src/main/resources/com/intel/mtwilson/database/mysql/mtwilson.sql
fi

# create Open Attestation configuration files
echo "create OpenAttestation configuration files"
if [ ! -e /etc/intel/cloudsecurity ]; then
  mkdir --parents /etc/intel/cloudsecurity
fi

echo 'mtwilson.api.baseurl=https://'$HOSTNAME':8181
mtwilson.api.ssl.policy=TRUST_FIRST_CERTIFICATE
mtwilson.db.driver=com.mysql.jdbc.Driver
mtwilson.db.url=jdbc:mysql://localhost/mw_as
mtwilson.db.user=root
mtwilson.db.password=password' > /etc/intel/cloudsecurity/mtwilson.properties

echo 'PrivacyCaUrl=https://'$HOSTNAME':8181/HisPrivacyCAWebServices2
PrivacyCaSubjectName=HIS_PRIVACY_CA
PrivacyCaPassword=password
EndorsementCaSubjectName=Endorsement_CA_Rev_1
EndorsementCaPassword=password
CertValidityDays=3652
AikAuth=1111111111111111111111111111111111111111' > /etc/intel/cloudsecurity/privacyca-client.properties

echo 'ClientFilesDownloadUsername=admin
ClientFilesDownloadPassword=password' > /etc/intel/cloudsecurity/PrivacyCA.properties

echo 'com.intel.mountwilson.as.trustagent.timeout=3
com.intel.mountwilson.as.attestation.hostTimeout=60
com.intel.mountwilson.as.home=/var/opt/intel/aikqverifyhome
com.intel.mountwilson.as.aikqverify.cmd=aikqverify
com.intel.mountwilson.as.openssl.cmd=openssl.sh
saml.key.aslias=samlkey1
saml.keystore.file=SAML.jks
saml.keystore.password=password
saml.validity.seconds=3600
saml.issuer=https://'$SERVER_IP':8181
saml.key.password=password
privacyca.server='$SERVER_IP'
com.intel.mtwilson.as.buisiness.trust=sleepTime=1' > /etc/intel/cloudsecurity/attestation-service.properties

echo 'mtwilson.tdbpkeystore.dir=/etc/intel/cloudsecurity
mtwilson.tdbp.keystore.password=password
imagesRootPath= images/
trustUnknown = images/Unknown.png
trustTrue = images/Trusted.png
trustFalse = images/UnTrusted.png
ubuntu = images/ubuntu.ong
vmware = images/vmware.png
suse = images/suse.png
kvm = images/kvm.png
xen = images/xen.png
mtwilson.tdbp.sessionTimeOut = 1800
mtwilson.tdbp.paginationRowCount = 10' > /etc/intel/cloudsecurity/trust-dashboard.properties

echo 'mtwilson.wlmp.keystore.dir=/etc/intel/cloudsecurity
mtwilson.wlmp.keystore.password=password
mtwilson.wlmp.openSourceHypervisors=KVM;Xen
mtwilson.wlmp.sessionTimeOut=1800
mtwilson.wlmp.pagingSize=8' > /etc/intel/cloudsecurity/whitelist-portal.properties

# install aikqverify
echo "install aikqverify"
cd $HOME
rm -rf aikqverify*
cp $OPEN_ATTESTATION/services/aikqverify/target/aikqverify-1.2-SNAPSHOT.zip $HOME
unzip aikqverify-1.2-SNAPSHOT.zip
cd aikqverify-1.2-SNAPSHOT
make
make install

# create saml signing key
echo "create saml signing key"
cd /etc/intel/cloudsecurity
keytool -genkey -alias saml.key.alias -keyalg RSA -keysize 2048 -keystore saml.keystore.file -storepass saml.keystore.password -dname "CN=OpenAttestation, O=Security, OU=LTC, C=US" -validity 3650 -keypass saml.key.password
keytool -export -alias saml.key.alias -keystore saml.keystore.file -storepass saml.keystore.password -file saml.crt
openssl x509 -in saml.crt -inform der -out saml.crt.pem -outform pem

# create EK signing certificate
echo "create EK signing certificate"
cd /etc/intel/cloudsecurity
java -jar $OPEN_ATTESTATION/trust-agent/HisPrivacyCAWebServices2/target/HisPrivacyCAWebServices2-1.2-SNAPSHOT-setup.jar

cp /etc/intel/cloudsecurity/clientfiles/hisprovisioner.properties /etc/intel/cloudsecurity/

export endorsement_password=password
openssl pkcs12 -in clientfiles/endorsement.p12 -out privacyca-endoresement.pem -nokeys -passin env:endorsement_password
openssl x509 -inform pem -in privacyca-endoresement.pem -out privacyca-endorsement.crt -outform der
cp /etc/intel/cloudsecurity/clientfiles/PrivacyCA.cer /etc/intel/cloudsecurity/PrivacyCA.cer

# create attestation server certificate
echo "create attestation server certificate"
if [ ! -e /etc/tomcat6/Certificate ]; then
  mkdir /etc/tomcat6/Certificate
fi
cd /etc/tomcat6/Certificate
rm -rf keystore.jks
keytool -genkey -alias s1as -keyalg RSA -keysize 2048 -keystore keystore.jks -storepass password -dname "CN=$SERVER_IP, O=Security, OU=LTC, C=US" -validity 3650 -keypass password
keytool -exportcert -alias s1as -keystore keystore.jks -storepass password -file ssl.$SERVER_IP.crt
openssl x509 -in ssl.$SERVER_IP.crt -inform der -out ssl.$SERVER_IP.crt.pem -outform pem

# create portal signing key
echo "create portal signing key"
cd /etc/intel/cloudsecurity
keytool -genkey -alias admin -keyalg RSA -keysize 2048 -keystore portal.jks -storepass password -dname "CN=$PORTAL_USER, O=Security, OU=LTC, C=US" -validity 3650 -keypass password
keytool -importcert -file saml.crt -keystore portal.jks -storepass password -alias "mtwilson (saml)"
keytool -importcert -file /etc/tomcat6/Certificate/ssl.$SERVER_IP.crt -keystore portal.jks -storepass password -alias "mtwilson (ssl)"

# create oVirt signing key
echo "create oVirt signing key"
cd /etc/intel/cloudsecurity
keytool -genkey -alias ovirtssl -keyalg RSA  -keysize 2048 -keystore ovirt.jks -storepass password -dname "CN=$SERVER_IP, O=Security, OU=LTC, C=US" -validity 3650  -keypass password
keytool -export -alias ovirtssl -keystore ovirt.jks -storepass password -file ovirtssl.crt 
keytool -importcert -file /etc/tomcat6/Certificate/ssl.$SERVER_IP.crt -keystore ovirt.jks -storepass password  -alias "attestation server"

# deploy the web services
echo "deploy the web services"
cd /etc/tomcat6
cp $OPEN_ATTESTATION/trust-agent/HisPrivacyCAWebServices2/target/HisPrivacyCAWebServices2.war HisPrivacyCAWebServices2.war
cp $OPEN_ATTESTATION/services/WLMService/target/WLMService-1.2-SNAPSHOT-core.war WLMService.war
cp $OPEN_ATTESTATION/portals/WhiteListPortal/target/WhiteListPortal-1.2-SNAPSHOT-core.war WhiteListPortal.war
cp $OPEN_ATTESTATION/services/AttestationService/target/AttestationService-1.2-SNAPSHOT-core.war AttestationService.war
cp $OPEN_ATTESTATION/portals/TrustDashBoard/target/TrustDashBoard-1.2-SNAPSHOT-core.war TrustDashBoard.war
service tomcat6 restart
