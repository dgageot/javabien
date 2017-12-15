---
title: "Fibonacci with an interconnected network of Docker containers"
date: 2014-06-19T12:00:00+01:00
tags: ["docker"]
---

On Monday, I posted a [tutorial]({{< relref "2014/06/16/recursive-fibonacci-with-docker.md" >}})
on how to compute fibonacci numbers with a recursive algorithm that spawns Docker containers inside docker containers.

<blockquote>
  But can we do rather spawn a network of interconnected docked?
</blockquote>

Yes. Here's the project to do that: <a href="https://github.com/dgageot/fiboweb">Fiboweb</a>

this version of Fibonacci uses Docker to spawn web servers that communicate one with the others.

Each web server knows the value of the <code>Nth</code> Fibonacci number.
To know this value, it has to connect to the web server that knows <code>N-2</code> and the web server that knows <code>N-1</code>.

Our script <code>startNetwork.sh</code> takes <code>N</code> as a parameter and spawns N docker daemons. Each docker container
except #0 and #1 is <a href="https://docs.docker.com/userguide/dockerlinks/">linked</a> to two other docker containers so that it can query them on their port 8000 with wget.

The last docker container maps its 8000 port to the host so that it can be queried.

<blockquote>
  Here's the docker file:
</blockquote>

```docker
FROM google/debian:wheezy
MAINTAINER David Gageot david@gageot.net
```
