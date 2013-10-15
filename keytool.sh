#!/bin/sh

OAT=$1
GLASSFISH_HOME=$2
HOST=$3
USER=$4

# create saml signing key
echo "create saml signing key"
cd /etc/intel/cloudsecurity
rm -rf saml.crt
rm -rf saml.crt.pem
rm -rf saml.keystore.file
keytool -genkey -alias saml.key.alias -keyalg RSA -keysize 2048 -keystore saml.keystore.file -storepass saml.keystore.password -dname "CN=OpenAttestation, O=Security, OU=LTC, C=US" -validity 3650 -keypass saml.key.password
keytool -export -alias saml.key.alias -keystore saml.keystore.file -storepass saml.keystore.password -file saml.crt
openssl x509 -in saml.crt -inform der -out saml.crt.pem -outform pem

# create EK signing certificate
echo "create EK signing certificate"
cd /etc/intel/cloudsecurity
java -jar $OAT/trust-agent/HisPrivacyCAWebServices2/target/HisPrivacyCAWebServices2-2.0-setup.jar

cp /etc/intel/cloudsecurity/clientfiles/hisprovisioner.properties /etc/intel/cloudsecurity/

export endorsement_password=password
openssl pkcs12 -in clientfiles/endorsement.p12 -out privacyca-endoresement.pem -nokeys -passin env:endorsement_password
openssl x509 -inform pem -in privacyca-endoresement.pem -out privacyca-endorsement.crt -outform der
cp /etc/intel/cloudsecurity/clientfiles/PrivacyCA.cer /etc/intel/cloudsecurity/PrivacyCA.cer

# create attestation server certificate
echo "create attestation server certificate"
cd $GLASSFISH_HOME/domains/domain1/config
rm -rf keystore.jks
keytool -genkey -alias s1as -keyalg RSA -keysize 2048 -keystore keystore.jks -storepass password -dname "CN=$HOST, O=Security, OU=LTC, C=US" -validity 3650 -keypass password
keytool -exportcert -alias s1as -keystore keystore.jks -storepass password -file ssl.$HOST.crt
openssl x509 -in ssl.$HOST.crt -inform der -out ssl.$HOST.crt.pem -outform pem

# create truststore file and add certificate to truststore
echo "create truststore and add certificate to truststore"
rm -rf cacerts.jks
keytool -import -v -trustcacerts -alias s1as -file ssl.$HOST.crt -keystore cacerts.jks -keypass password

# create portal signing key
echo "create portal signing key"
cd /etc/intel/cloudsecurity
rm -rf portal.jks
keytool -genkey -alias admin -keyalg RSA -keysize 2048 -keystore portal.jks -storepass password -dname "CN=$USER, O=Security, OU=LTC, C=US" -validity 3650 -keypass password
keytool -importcert -file saml.crt -keystore portal.jks -storepass password -alias "mtwilson (saml)"
keytool -importcert -file $GLASSFISH_HOME/domains/domain1/config/ssl.$HOST.crt -keystore portal.jks -storepass password -alias "mtwilson (ssl)"

# create oVirt signing key
echo "create oVirt signing key"
cd /etc/intel/cloudsecurity
rm -rf ovirt.jks
keytool -genkey -alias ovirtssl -keyalg RSA  -keysize 2048 -keystore ovirt.jks -storepass password -dname "CN=$HOST, O=Security, OU=LTC, C=US" -validity 3650  -keypass password
keytool -export -alias ovirtssl -keystore ovirt.jks -storepass password -file ovirtssl.crt
keytool -importcert -file $GLASSFISH_HOME/domains/domain1/config/ssl.$HOST.crt -keystore ovirt.jks -storepass password  -alias "attestation server"
