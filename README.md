oat-scripts
===========

OpenAttestation build, install and configuration scripts

Tomcat6 users:
Set PORTAL_USER, SERVER_IP, and OPEN_ATTESTATION variables
./oat-tomcat

Glassfish users:
Set PORTAL_USER, SERVER_IP, OPEN_ATTESTATION, and GLASSFISH_HOME variables
./glassfish
Login glassfish web portal, http://localhost:4848/common/index.jsf

Browse to Configuration > server-config > Network Config > Protocols > http-listener-2

Click on the SSL tab, add following ciphers:
TLS_ECDH_anon_WITH_AES_256_CBC_SHA, 
TLS_ECDH_anon_WITH_AES_128_CBC_SHA, 
TLS_ECDH_anon_WITH_3DES_EDE_CBC_SHA, 
TLS_ECDH_RSA_WITH_AES_256_CBC_SHA, 
TLS_ECDH_RSA_WITH_AES_128_CBC_SHA, 
TLS_ECDH_RSA_WITH_3DES_EDE_CBC_SHA, 
TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA, 
TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA, 
TLS_ECDHE_ECDSA_WITH_3DES_EDE_CBC_SHA, 
TLS_ECDH_ECDSA_WITH_AES_256_CBC_SHA, 
TLS_ECDH_ECDSA_WITH_AES_128_CBC_SHA, 
TLS_ECDH_ECDSA_WITH_3DES_EDE_CBC_SHA, 
TLS_DHE_RSA_WITH_AES_256_CBC_SHA, 
TLS_DHE_DSS_WITH_AES_256_CBC_SHA, 
TLS_RSA_WITH_AES_256_CBC_SHA, 
TLS_DHE_RSA_WITH_AES_128_CBC_SHA, 
TLS_DHE_DSS_WITH_AES_128_CBC_SHA, 
TLS_RSA_WITH_AES_128_CBC_SHA 

Click Save
$GLASSFISH_HOME/bin/asadmin restart-domain

./oat-glassfish
