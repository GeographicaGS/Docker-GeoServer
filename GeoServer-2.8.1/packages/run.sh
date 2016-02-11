#!/bin/bash

# Start GeoServer
exec gosu tomcat $CATALINA_HOME/bin/catalina.sh run
