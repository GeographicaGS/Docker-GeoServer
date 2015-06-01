Docker Image for GeoServer
==========================

What does this Docker image contains?
-------------------------------------
The following:

- an Oracle Java Virtual Machine Server JDK, installed not from packages, but from the binaries provided by Oracle;

- Apache Tomcat as provided by the Apache Foundation (not from packages);

- the Apache Portable Runtime, compiled from source, and enabled into Tomcat;

- GeoServer, deployed in Tomcat from the war file.

Check _Tags_ for version info.


Tags
----
Different versions may be available in the future. By now:

- __v2.6.2:__ Oracle Java Virtual Machine Server JDK 1.7.0-75, Apache Tomcat 8.0.18, Apache Portable Runtime 1.5.1, and GeoServer 2.6.2.


Usage Pattern
-------------
Build the image directly from GitHub (this can take a while):

```Shell
docker build -t="geographica/geoserver:v2.6.2" https://github.com/GeographicaGS/Docker-GeoServer.git
```

or pull it from Docker Hub:

```Shell
docker pull geographica/geoserver:v2.6.2
```

To start the container interactively:

```Shell
docker run -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data --name whatever geographica/geoserver:v2.6.2 /bin/bash
```

To start Tomcat directly:

```Shell
docker run -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data --name whatever geographica/geoserver:v2.6.2
```

Tomcat's output can be seen and it can be closed with CTRL-C.

Several environmental variables are exposed to control such things as ports, JVM memory parameters, and JMX activation. For example, to tweak memory usage limits for the JVM:

```Shell
docker run -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -e "MEM=512m" -e "MMEM=512m" -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data --name whatever geographica/geoserver:v2.6.2
```

GeoServer data folder is located by default at __/var/geoserver-data__ inside the container, although that can be changed via environmental variables too. Mount a volume to the host system as shown in the latter command.
