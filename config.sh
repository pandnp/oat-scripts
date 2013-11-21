#!/bin/sh

# TODO : we need secure password storage

HOSTNAME=`/bin/hostname`
SERVER_IP=$1
USER=$2

# create configuration files
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

echo 'ClientFilesDownloadUsername='$USER'
ClientFilesDownloadPassword=password' > /etc/intel/cloudsecurity/PrivacyCA.properties

echo 'com.intel.mountwilson.as.trustagent.timeout=3
com.intel.mountwilson.as.attestation.hostTimeout=60
com.intel.mountwilson.as.home=/var/opt/intel/aikverifyhome
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
trustUnknow = images/Unknown.png
trustTrue = images/Trusted.png
trustFalse = images/UnTrusted.png
ubuntu = images/ubuntu.png
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
