# Version: 0.0.1
FROM geographica/apache-tomcat:v8.0.18

MAINTAINER Juan Pedro Perez "jp.alcantara@geographica.gs"

# This is a clever instruction, for, if changed, will force the build command to
# skip cache and recreate the whole image from scratch
ENV REFRESHED_AT 2015-04-06
ENV JRE_HOME /usr/local/jdk1.7.0_75/jre

# Install JAI
WORKDIR ${JRE_HOME}
ADD packages/jai-1_1_3-lib-linux-amd64-jre.bin ./
ADD packages/jai_imageio-1_1-lib-linux-amd64-jre.bin ./
RUN chmod 755 jai-1_1_3-lib-linux-amd64-jre.bin
RUN chmod 755 jai_imageio-1_1-lib-linux-amd64-jre.bin
RUN yes | ./jai-1_1_3-lib-linux-amd64-jre.bin
RUN yes | ./jai_imageio-1_1-lib-linux-amd64-jre.bin



# ENV JAVA_HOME /usr/local/jdk1.7.0_75

# ENV ANT_HOME /usr/local/apache-ant-1.9.4
# ENV CATALINA_HOME /usr/local/apache-tomcat-8.0.18
# ENV PATH $JAVA_HOME/bin:$JRE_HOME/bin:$ANT_HOME/bin:$PATH
# ENV LD_LIBRARY_PATH /usr/local/lib


# # Some dependencies to have a build chaintool
# RUN apt-get update
# RUN apt-get install -y build-essential libssl-dev

# # Install the Server JRE
# WORKDIR /usr/local/
# ADD packages/server-jre-7u75-linux-x64.tar.gz /usr/local
# RUN chown -R root:root jdk1.7.0_75


# # Install Apache Ant
# ADD packages/apache-ant-1.9.4-bin.tar.bz2 /usr/local
# WORKDIR /usr/local/apache-ant-1.9.4
# RUN ant -f fetch.xml -Ddest=system


# # Install Apache Tomcat 8.0.18 to /usr/local
# ADD packages/apache-tomcat-8.0.18.tar.gz /usr/local
# RUN groupadd tomcat
# RUN useradd -r -s /sbin/nologin -g tomcat -d /usr/local/apache-tomcat-8.0.18/ tomcat
# RUN echo "tomcat:tomcat" | chpasswd


# # Install the Native Tomcat Apache Portable Runtime
# RUN mkdir -p /usr/local/src/
# ADD packages/apr-1.5.1.tar.gz /usr/local/src
# WORKDIR /usr/local/src/apr-1.5.1
# RUN ./configure --prefix=/usr/local
# RUN make
# RUN make install
# RUN ldconfig
# RUN rm -Rf /usr/local/src


# # Enable APR in Tomcat
# WORKDIR /usr/local/apache-tomcat-8.0.18/bin
# RUN tar -xzvf tomcat-native.tar.gz
# WORKDIR /usr/local/apache-tomcat-8.0.18/bin/tomcat-native-1.1.32-src/jni
# RUN ant
# WORKDIR /usr/local/apache-tomcat-8.0.18/bin/tomcat-native-1.1.32-src/jni/native
# RUN ./configure --with-apr=/usr/local --with-java-home=$JAVA_HOME --with-ssl=/usr/local --prefix=$CATALINA_HOME
# RUN make
# RUN make install
# RUN ldconfig


# # Final ownership and permissions
# RUN chown -R tomcat:tomcat /usr/local/apache-tomcat-8.0.18
# RUN chmod 770 -R /usr/local/apache-tomcat-8.0.18/webapps


# # Clean src
# RUN rm -Rf /usr/local/src


# # Install Tomcat environment options
# WORKDIR /usr/local/apache-tomcat-8.0.18/
# ADD packages/setenv.sh bin/

# EXPOSE 8080
# CMD su -s /bin/bash tomcat -c "/usr/local/apache-tomcat-8.0.18/bin/catalina.sh run"
