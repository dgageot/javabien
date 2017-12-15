---
title: "Copy a Docker image from one host to another"
date: 2014-03-20T12:00:00+01:00
tags: ["docker","google","gce"]
---

Last Monday, I was speaking at the <a href="http://nantesjug.org/#/events/2014_03_17">Nantes JUG</a>. During the presentation, I deploy a Java application on Google Compute Engine. To run the application, I use a Docker image that has Java 8 installed.

While <a href="http://nantesjug.org/#/speakers/pierre_reliquet">Pierre Reliquet</a> was giving a talk about AngularDart, I thought it was a good idea to check that the <em>deploy part</em> of my talk works just fine.

<blockquote>
  Guess what? It didn't.
</blockquote>

The docker image I used to work with is not on the compute engine instance anymore. And I remember I used this very instance to experiment a lot of things. I must have broken something. Not a problem, I decide to spawn a new instance from a disk snapshot I know is working.

<blockquote>
  I should have said "I thought was working".
</blockquote>

On this snapshot, Docker is installed properly but the image is not created yet. No problem, I run <code>docker build</code> from the <code>Dockerfile</code> to recreate a docker instance with java 8 installed.

<blockquote>
  Guess what? It didn't work.
</blockquote>

Turns out that a <code>Dockerfile</code> is very reproductible as long as you access external resources that are still there. In my case, I use a custom package repository that used to contain early releases of Java 8. The url for these packages was moved or is not responding anymore.

```bash
# Install java8
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
```

<blockquote>
  Little moment of panic. My talk is to take place in 15 minutes.
</blockquote>

One thing nice with docker is that you can run the same image on remote servers or locally. By chance, I've got THE image I need on my machine.

<blockquote>
  So let's upload this image to the remote instance
</blockquote>

It's pretty easy. You need to dump the image to a file, upload this file, then extract the image back from the file.

```bash
local  $ docker save dgageot/java8 > image.tar
local  $ gcutils push remote_instance image.tar .
local  $ gcutils ssh remote_instance
remote $ docker load dgageot/java8 < image.tar
```

<blockquote>
  Docker saved the day!
</blockquote>
