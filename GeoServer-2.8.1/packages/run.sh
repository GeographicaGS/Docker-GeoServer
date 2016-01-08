#!/bin/bash

# Check if geoserver.war exists

if [ ! -f $CATALINA_HOME/webapps/geoserver.war ]; then

    # Install GeoServer WAR
    unzip $CATALINA_HOME/webapps/geoserver-2.8.1-war.zip -d $CATALINA_HOME/webapps/
    chown -R tomcat:tomcat $CATALINA_HOME
    chmod 665 $CATALINA_HOME/webapps/geoserver.war
    rm -f $CATALINA_HOME/webapps/geoserver-2.8.1-war.zip

fi

# Start GeoServer
exec gosu tomcat $CATALINA_HOME/bin/catalina.sh run
