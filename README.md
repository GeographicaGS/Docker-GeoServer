Docker Image for GeoServer
==========================

This is the README.md for Docker tag __v2.6.2__. Please refer to the __Master__ README.md for updated information.

What does this Docker image contains?
-------------------------------------
The following:

- an Oracle Java Virtual Machine Server JDK, installed not from packages, but from the binaries provided by Oracle;

- Apache Tomcat as provided by the Apache Foundation (not from packages);

- the Apache Portable Runtime, compiled from source, and enabled into Tomcat;

- GeoServer, deployed in Tomcat from the war file.

Check _Tags_ for version info.


Versions
--------
Different versions may be available in the future. By now:

- __v2.6.2:__ Oracle Java Virtual Machine Server JDK 1.7.0-75, Apache Tomcat 8.0.18, Apache Portable Runtime 1.5.1, and GeoServer 2.6.2.

Guidelines for Creating New Docker Tags in this Repository
----------------------------------------------------------
Each Docker tag in this repository addresses changes in library versions bundled together. Follow this guidelines when creating new Docker tags for this repo:

- to create and maintain new Docker tags, make a GIT branch with a descriptive name. Each tag must match its branch in name. Do not use GIT tags to support Docker tags, for branches does exactly the same job and does it better in this case. Never destroy those branches and keep them open;

- the master branch should reflect the most updated README.md. This means that the master branch may not point to the most "advanced" branch in terms of library versions. But always refer to the master README.md for the most updated information;

- don't forget to document detailed information about the new GIT branch / Docker tag in the former section;

- don't forget to update the first line of this README.md warning about the README.md version to tell the user about the README.md being read.

Usage Pattern
-------------
Build the image directly from GitHub (this can take a while):

```Shell
git checkout tagbranch

docker build -t="geographica/geoserver:v2.6.2" .
```

or pull it from Docker Hub:

```Shell
docker pull geographica/geoserver:v2.6.2
```

__Just a silly reminder to myself:__ there is no need to configure the Tomcat port inside the container, for the port mapping container-host will provide the final connecting port. Inside the container, Tomcat port will always be 8080, no need to change that.

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
docker run -ti -p 8080:8080 -p 3333:3333 -p 62911:62911 -e "JMX=false" -e "XMX=512m" -e "XMS=512m" -e "MAXPERMSIZE=1024k" -v /home/malkab/Desktop/geoserver-data:/var/geoserver-data --name whatever geographica/geoserver:v2.6.2
```

GeoServer data folder is located by default at __/var/geoserver-data__ inside the container, although that can be changed via environmental variables too. Mount a volume to the host system as shown in the latter command.

To enter into an existing container with a shell:

```Shell
docker start whateverthecontainername

docker exec -ti whateverthecontainername /bin/bash
```

To check the log:

```Shell
docker exec -ti geoserver_test tail -f -n 50 /var/geoserver-data/logs/geoserver.log
```
