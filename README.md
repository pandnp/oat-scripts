oat-scripts
===========

OpenAttestation build, install and configuration scripts

Install dependencies

# apt-get install git maven
# apt-get install openjdk-7-jdk
# apt-get install zip make g++ makeself
# apt-get install openssl libssl-dev
# apt-get install mysql-server

Download and build OpenAttestation

# cd $HOME
# git clone https://github.com/OpenAttestation/OpenAttestation
# cd OpenAttestation
# git checkout next
# mvn clean install

Download scripts and install OpenAttestation

# cd $HOME
# git clone https://github.com/pandnp/oat-scripts
# sh oat.sh $USER $IP $OAT_HOME
