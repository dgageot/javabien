---
title: "Give a docker container full access to host's network"
date: 2014-06-12T12:00:00+01:00
tags: ["docker"]
---

When a docker container is run, is has networking enabled with its own network stack. That means:

 + It uses its own ports
 + To give access from the host to the container one has to forward ports
 + Giving access from the container to the host is not as easy as it seems. Basically there's no official way for the container to find out host's IP. There are <a href="https://github.com/dotcloud/docker/issues/1143">workarounds</a>

An easy way to give the container full access to the host is to have the container use the same stack as the host by using <code>--net host</code> switch at run time.

For example, it makes it trivial to run an nginx reverse proxy, inside a container, to serve a webapp started on the host.

<blockquote>
  More about that tomorrow!
</blockquote>
