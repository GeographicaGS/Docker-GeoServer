# Update and download basic packages
apt-get update && apt-get install unzip

# Install JCE Policy
unzip ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip -d ${JRE_HOME}/lib/security/
cp ${JRE_HOME}/lib/security/UnlimitedJCEPolicy/* ${JRE_HOME}/lib/security
rm -Rf ${JRE_HOME}/lib/security/UnlimitedJCEPolicy
rm -f ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip

# Install JAI and ImageIO
cd ${JRE_HOME}
chmod 755 ${JRE_HOME}/jai-1_1_3-lib-linux-amd64-jre.bin
chmod 755 ${JRE_HOME}/jai_imageio-1_1-lib-linux-amd64-jre.bin
yes | ./jai-1_1_3-lib-linux-amd64-jre.bin
yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin
rm -f ./jai*.bin

# Install GeoServer WAR
unzip ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip -d ${CATALINA_HOME}/webapps/
chown -R tomcat:tomcat ${CATALINA_HOME}
chmod 665 ${CATALINA_HOME}/webapps/geoserver.war
mkdir ${GEOSERVER_DATA_DIR}

# Configure user and group
chown -R tomcat:tomcat ${GEOSERVER_DATA_DIR}
useradd --shell /bin/sh --home ${GEOSERVER_DATA_DIR} -g tomcat geoserver-admin
echo "geoserver-admin:geoserver-admin" | chpasswd
rm -f ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip

# Clean up
rm -Rf /usr/local/compile.sh
