#!/bin/bash

# Check if geoserver.war exists

if [ ! -f $CATALINA_HOME/webapps/geoserver.war ]; then

    # Install GeoServer WAR
    unzip $CATALINA_HOME/webapps/geoserver-2.6.2-war.zip -d $CATALINA_HOME/webapps/
    chown -R tomcat:tomcat $CATALINA_HOME
    chmod 665 $CATALINA_HOME/webapps/geoserver.war
    rm -f $CATALINA_HOME/webapps/geoserver-2.6.2-war.zip

    su tomcat $CATALINA_HOME/bin/catalina.sh run

    while [ ! -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib ]; do
	sleep 2
    done

    unzip $CATALINA_HOME/webapps/geoserver-2.6.2-wps-plugin.zip -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib
    chown -R tomcat:tomcat $CATALINA_HOME
    rm -f $CATALINA_HOME/webapps/geoserver-2.6.2-wps-plugin.zip

    su tomcat $CATALINA_HOME/bin/catalina.sh stop
    
fi

# Start GeoServer
exec gosu tomcat $CATALINA_HOME/bin/catalina.sh run
