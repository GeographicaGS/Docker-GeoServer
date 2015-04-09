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
RUN chmod 755 jai-1_1_3-lib-linux-amd64-jre.bin && chmod 755 jai_imageio-1_1-lib-linux-amd64-jre.bin && yes | ./jai-1_1_3-lib-linux-amd64-jre.bin && yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin



# EXPOSE 8080
# CMD su -s /bin/bash tomcat -c "/usr/local/apache-tomcat-8.0.18/bin/catalina.sh run"
