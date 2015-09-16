# Version: 0.0.1
FROM geographica/apache-tomcat:v8.0.18

MAINTAINER Juan Pedro Perez "jp.alcantara@geographica.gs"

# Environment
ENV JAVA_HOME /usr/local/jdk1.7.0_75
ENV JRE_HOME /usr/local/jdk1.7.0_75/jre
ENV ANT_HOME /usr/local/apache-ant-1.9.4
ENV CATALINA_HOME /usr/local/apache-tomcat-8.0.18
ENV PATH $JAVA_HOME/bin:$JRE_HOME/bin:$ANT_HOME/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib:$CATALINA_HOME/lib:$LD_LIBRARY_PATH
ENV GEOSERVER_DATA_DIR /var/geoserver-data
# To use JMX or not
ENV JMX false
# JMX port
ENV JMX_PORT 3333
ENV JMX_HOSTNAME localhost
ENV JMX_CONF_FOLDER $CATALINA_HOME/conf
# JMX access file
ENV JMX_ACCESS_FILE $JMX_CONF_FOLDER/jmxremote.access
# JMX password file
ENV JMX_PASSWORD_FILE $JMX_CONF_FOLDER/jmxremote.password
# Max heap size
ENV XMX 1024m
# Initial heap size
ENV XMS 1024m
# PermSize size
ENV MAXPERMSIZE 512m


# Copy assets
WORKDIR ${JRE_HOME}
ADD packages/jai-1_1_3-lib-linux-amd64-jre.bin ./
ADD packages/jai_imageio-1_1-lib-linux-amd64-jre.bin ./
ADD packages/UnlimitedJCEPolicyJDK7.zip ./lib/security/
ADD packages/geoserver-2.6.2-war.zip ${CATALINA_HOME}/webapps/
ADD packages/compile.sh /usr/local/

# Do everything
WORKDIR /usr/local/
RUN chmod 777 compile.sh
RUN ./compile.sh

VOLUME /var/geoserver-data
VOLUME /usr/local/apache-tomcat-8.0.18/logs

EXPOSE 8080
EXPOSE 3333
EXPOSE 62911
CMD su -s /bin/bash tomcat -c "$CATALINA_HOME/bin/catalina.sh run"
