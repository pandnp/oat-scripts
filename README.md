oat-scripts
===========

OpenAttestation build, install and configuration scripts

### Install dependencies

````
$ sudo apt-get install git maven openjdk-6-jdk openjdk-7-jdk zip make g++ makeself
$ sudo apt-get install openssl libssl-dev mysql-server
````

Leave mysql password blank

### Download source and build OpenAttestation

````
$ cd $HOME
$ git clone https://github.com/OpenAttestation/OpenAttestation
$ cd OpenAttestation
$ git checkout next
$ mvn clean install
````

### Download scripts and install OpenAttestation

````
$ cd $HOME
$ git clone https://github.com/pandnp/oat-scripts
$ cd oat-scripts
$ sudo ./oat.sh $USER $OAT_HOME
$ cd $HOME
$ sudo glassfish3/glassfish/bin/asadmin restart-domain domain1
````
