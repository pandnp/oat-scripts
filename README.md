oat-scripts
===========

OpenAttestation build, install and configuration scripts

### Install dependencies

sudo apt-get install git maven openjdk-7-jdk zip make g++ makeself openssl libssl-dev mysql-server

### Download and build OpenAttestation

cd $HOME

git clone https://github.com/OpenAttestation/OpenAttestation

cd OpenAttestation

git checkout next

mvn clean install

### Download scripts and install OpenAttestation

cd $HOME

git clone https://github.com/pandnp/oat-scripts

cd oat-scripts

sudo ./oat.sh $USER $IP $OAT_HOME

cd $HOME

sudo glassfish3/glassfish/bin/asadmin restart-domain domain1
