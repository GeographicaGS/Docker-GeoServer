GeoServer 2.8.1
===============

Versions
--------
This image is based on [geographica/apache-tomcat:v8.0.18](https://github.com/GeographicaGS/Docker-Apache-Tomcat).

This Dockerfile deploys the following software:

- an Oracle Java Virtual Machine Server JDK, installed not from packages, but from the binaries provided by Oracle;

- Apache Tomcat as provided by the Apache Foundation (not from packages);

- the Apache Portable Runtime, compiled from source, and enabled into Tomcat;

- native JAI and JAI ImageIO;

- GeoServer 2.8.1 bundled with the WPS extension, directly deployed in Tomcat (originally deployed from war file).


Usage Pattern
-------------
Build the image directly from GitHub (this can take a while):

```Shell
cd GeoServer-2.8.1

docker build -t="geographica/geoserver:v2.8.1" .
```

or pull it from Docker Hub:

```Shell
docker pull geographica/geoserver:v2.8.1
```

Inside the container, Tomcat port will always be 8080, no need to change that.

To start the container interactively (usually with --rm, for debugging):

```Shell
docker run -ti -p 8080:8080 --rm -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data \
--name whatever geographica/geoserver:v2.8.1 /bin/bash
```

To start Tomcat directly and check output, also for debugging:

```Shell
docker run -ti -p 8080:8080 -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data \
--name whatever geographica/geoserver:v2.8.1
```

Tomcat's output can be seen and it can be closed with CTRL-C.

Several environmental variables are exposed to control such things as ports, JVM memory parameters, and JMX activation. For example, to tweak memory usage limits for the JVM:

```Shell
docker run -ti -p 8080:8080 -e "XMX=1024m" -e "XMS=1024m" -e "MAXPERMSIZE=1024m" \
-v /home/malkab/Desktop/geoserver-data:/var/geoserver-data \
--name whatever geographica/geoserver:v2.8.1
```

GeoServer data folder is located by default at __/var/geoserver-data__ inside the container, although that can be changed via environmental variables too. The volume is exposed, as well as __/usr/local/apache-tomcat-8.0.18/logs__ to access logs. A volume to the host system can be mounted as shown in the latter command, but remember that this is considered a hack.

In normal conditions, run the container this way:

```Shell
docker run -d -P --name whatever geographica/geoserver:v2.8.1
```

To enter into an existing container with a shell:

```Shell
docker start whateverthecontainername

docker exec -ti whateverthecontainername /bin/bash
```

To check the log, either go to the volume or:

```Shell
docker exec -ti geoserver_test tail -f -n 50 /var/geoserver-data/logs/geoserver.log
```

For more details, check [geographica/Docker-Apache-Tomcat](https://github.com/GeographicaGS/Docker-Apache-Tomcat).


Deployment
----------
After deployment, some configuration is needed. For example, enable GeoServer logs and create the log file:

```Shell
docker exec geoserver_test touch /var/geoserver-data/logs/geoserver.log
```


Bundle Creation for New Versions
--------------------------------
Due to lack of enough skill with Tomcat, a fully automatized deployment at container creation by extracting the war, installing plugins into _webapps/geoserver/WEB-INF/lib_, and restarting Tomcat couldn't be achieved. The file _packages/geoserver-2.8.1-bundle.tar.bz2_ was created by deploy the GeoServer WAR, installing on it the required plugins and taring the resulting __geoserver__ folder into the aforementioned file. This file is just simply expanded into _$CATALINA_HOME/webapps/_ and good to go, GeoServer+plugins available. Repeat this procedure in case a new plugin needs to be added to the default configuration.
