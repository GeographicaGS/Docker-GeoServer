Docker Image for Oracle JVM & Apache Tomcat
===========================================

What does this Docker image contains?
-------------------------------------
The following:

- an Oracle Java Virtual Machine Server JDK, installed not from packages, but from the binaries provided by Oracle;

- binary Apache Ant;

- Apache Tomcat as provided by the Apache Foundation (not from packages);

- the Apache Portable Runtime, compiled from source, and enabled into Tomcat.

Check _Tags_ for version info.


Tags
----
Different versions may be available in the future. By now:

- __v8.0.18:__ Oracle Java Virtual Machine Server JDK 1.7.0-75, Apache Ant 1.9.4, Apache Tomcat 8.0.18, and Apache Portable Runtime 1.5.1.

Usage Pattern
-------------
Build the image directly from GitHub (this can take a while):

```Shell
docker build -t="geographica/apache-tomcat:v8.0.18" https://github.com/GeographicaGS/Docker-Apache-Tomcat.git
```

or pull it from Docker Hub:

```Shell
docker pull geographica/apache-tomcat
```

To start the container interactively:

```Shell
docker run -ti -p 8080:8080 --name whatever geographica/apache-tomcat:v8.0.18 /bin/bash
```

in case memory needs to be increased for the JVM, for example. Apache Tomcat environment is detailed in _bin/setenv.sh_.

To start Tomcat directly:

```Shell
docker run -ti -p 8080:8080 --name whatever geographica/apache-tomcat:v8.0.18
```

Tomcat's output can be seen and it can be closed with CTRL-C.

TODO
----
Create another Docker with the JVM installed separately, and with JMX installed.

Externalize the webapps folder to a volume on the host.
