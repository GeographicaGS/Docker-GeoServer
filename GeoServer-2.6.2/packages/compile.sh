#!/bin/bash

# Update and download basic packages
apt-get update
apt-get install unzip

# Install JCE Policy
unzip $JRE_HOME/lib/security/UnlimitedJCEPolicyJDK7.zip -d $JRE_HOME/lib/security/
cp $JRE_HOME/lib/security/UnlimitedJCEPolicy/* $JRE_HOME/lib/security
rm -Rf $JRE_HOME/lib/security/UnlimitedJCEPolicy
rm -f $JRE_HOME/lib/security/UnlimitedJCEPolicyJDK7.zip

# Install JAI and ImageIO
cd $JRE_HOME
chmod 755 $JRE_HOME/jai-1_1_3-lib-linux-amd64-jre.bin
chmod 755 $JRE_HOME/jai_imageio-1_1-lib-linux-amd64-jre.bin
yes | ./jai-1_1_3-lib-linux-amd64-jre.bin
yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin
rm -f ./jai*.bin

# Configure user and group
mkdir -p $GEOSERVER_DATA_DIR
chown -R tomcat:tomcat $GEOSERVER_DATA_DIR
rm -f /usr/local/bin/compile.sh

