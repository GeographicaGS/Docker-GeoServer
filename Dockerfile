# Version: 0.0.1
FROM geographica/apache-tomcat:v8.0.18

MAINTAINER Juan Pedro Perez "jp.alcantara@geographica.gs"

# Environment
ENV GEOSERVER_DATA_DIR /var/geoserver-data
# To use JMX or not
ENV JMX true
# JMX port
ENV JMX_PORT 3333
ENV JMX_HOSTNAME localhost
ENV JMX_CONF_FOLDER $CATALINA_HOME/conf
# JMX access file
ENV JMX_ACCESS_FILE $JMX_CONF_FOLDER/jmxremote.access
# JMX password file
ENV JMX_PASSWORD_FILE $JMX_CONF_FOLDER/jmxremote.password
# Max heap size
ENV MEM 64m
# Initial heap size
ENV MMEM 64m

# Install JAI
WORKDIR ${JRE_HOME}
ADD packages/jai-1_1_3-lib-linux-amd64-jre.bin ./
ADD packages/jai_imageio-1_1-lib-linux-amd64-jre.bin ./
ADD packages/UnlimitedJCEPolicyJDK7.zip ./lib/security/
ADD packages/geoserver-2.6.2-war.zip ${CATALINA_HOME}/webapps/

RUN apt-get update && apt-get install unzip && unzip ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip -d ${JRE_HOME}/lib/security/ && cp ${JRE_HOME}/lib/security/UnlimitedJCEPolicy/* ${JRE_HOME}/lib/security && rm -Rf ${JRE_HOME}/lib/security/UnlimitedJCEPolicy && rm -f ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip && chmod 755 jai-1_1_3-lib-linux-amd64-jre.bin && chmod 755 jai_imageio-1_1-lib-linux-amd64-jre.bin && yes | ./jai-1_1_3-lib-linux-amd64-jre.bin && yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin && rm -f jai*.bin && unzip ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip -d ${CATALINA_HOME}/webapps/ && chown -R tomcat:tomcat ${CATALINA_HOME} && chmod 665 ${CATALINA_HOME}/webapps/geoserver.war && mkdir ${GEOSERVER_DATA_DIR} && chown -R tomcat:tomcat ${GEOSERVER_DATA_DIR} && useradd --shell /bin/sh --home ${GEOSERVER_DATA_DIR} -g tomcat geoserver-admin && echo "geoserver-admin:geoserver-admin" | chpasswd && rm -f ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip

EXPOSE 8080
EXPOSE 3333
EXPOSE 62911
CMD su -s /bin/bash tomcat -c "$CATALINA_HOME/bin/catalina.sh run"
