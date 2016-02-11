FROM geographica/apache-tomcat:v8.0.18

MAINTAINER Juan Pedro Perez "jp.alcantara@geographica.gs"

# Environment
ENV GEOSERVER_DATA_DIR /var/geoserver-data

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
# ADD packages/geoserver-2.8.1-war.zip $CATALINA_HOME/webapps/
# ADD packages/geoserver-2.8.1-wps-plugin.zip $CATALINA_HOME/webapps/
ADD packages/geoserver-2.8.1-bundle.tar.bz2 $CATALINA_HOME/webapps/
ADD packages/compile.sh /usr/local/bin/
ADD packages/run.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/run.sh
RUN chmod 777 /usr/local/bin/compile.sh
RUN /usr/local/bin/compile.sh

VOLUME $GEOSERVER_DATA_DIR
