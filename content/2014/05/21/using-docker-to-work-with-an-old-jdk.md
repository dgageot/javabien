---
title: "Using Docker to work with an old jdk"
date: 2014-05-21T12:00:00+01:00
tags: ["docker","java"]
---

Ever tried to work on an old project that requires that you install on old version of java. Say java 5. On a Mac... You know this nightmare that no windows user will ever face:

<blockquote>
  You want me to install an old jdk on my mac? Are you crazy? That's so complicated.
</blockquote>

An easy way to do that is to boot a linux/windows vm. An easier way is to use <a href="https://www.docker.io/">Docker</a>.

Here's the Dockerfile that creates a container with java6 inside. You can then use the container to build a maven project.

```docker
FROM ubuntu:12.04
MAINTAINER David Gageot

# Install java 6
RUN apt-get update
RUN apt-get install -y openjdk-6-jdk

# Install tools
RUN apt-get install -y maven

# Define mountable directories.
VOLUME ["/dir"]

# Define working directory.
WORKDIR /dir

# Define default command.
CMD ["java"]
```

Build the container with <code>docker build -t dgageot/java6 .</code>
Run the container with <code>docker run -t dgageot/java6 java</code> or <code>docker run -t dgageot/java6 mvn</code>

You can map a folder on your host to the /dir folder on docker so that the java inside the container is used to build the project outside the container.

<blockquote>
  Have fun!
</blockquote>
