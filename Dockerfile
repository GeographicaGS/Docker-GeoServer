# Version: 0.0.1
FROM geographica/apache-tomcat:v8.0.18

MAINTAINER Juan Pedro Perez "jp.alcantara@geographica.gs"

# This is a clever instruction, for, if changed, will force the build command to
# skip cache and recreate the whole image from scratch
ENV REFRESHED_AT 2015-04-06


# Install JAI
WORKDIR ${JRE_HOME}
ADD packages/jai-1_1_3-lib-linux-amd64-jre.bin ./
ADD packages/jai_imageio-1_1-lib-linux-amd64-jre.bin ./
ADD packages/UnlimitedJCEPolicyJDK7.zip ./lib/security/
ADD packages/geoserver-2.6.2-war.zip ${CATALINA_HOME}/webapps/
RUN apt-get install unzip && unzip ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip -d ${JRE_HOME}/lib/security/ && rm -f ${JRE_HOME}/lib/security/UnlimitedJCEPolicyJDK7.zip && chmod 755 jai-1_1_3-lib-linux-amd64-jre.bin && chmod 755 jai_imageio-1_1-lib-linux-amd64-jre.bin && yes | ./jai-1_1_3-lib-linux-amd64-jre.bin && yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin && rm -f jai*.bin && unzip ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip -d ${CATALINA_HOME}/webapps/ && chown -R tomcat:tomcat ${CATALINA_HOME} && chmod 665 ${CATALINA_HOME}/webapps/geoserver.war && useradd --shell /bin/sh --home /var/geoserver-data -g tomcat geoserver-admin && echo "geoserver-admin:geoserver-admin" | chpasswd && rm -f ${CATALINA_HOME}/webapps/geoserver-2.6.2-war.zip


EXPOSE 8080
CMD su -s /bin/bash tomcat -c "/usr/local/apache-tomcat-8.0.18/bin/startup.sh"
