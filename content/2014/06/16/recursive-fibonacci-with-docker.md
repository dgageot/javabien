---
title: "Recursive Fibonacci with Docker"
date: 2014-06-16T12:00:00+01:00
tags: ["docker","fun"]
---

I <a href="https://twitter.com/dgageot/status/477424725988487168">tweeted</a> this a couple of days ago but I had so much fun and so huge of a feedback that I decided to blog about it.

<a href="https://registry.hub.docker.com/u/dgageot/fiboid/">Here</a> you will find a Docker image that is able to compute Fibonnaci numbers using a trivial recursive algorithm that spawns Docker containers inside Docker containers.

All you have to do is run this command line:

```bash
docker run --rm --privileged -ti -v /var/lib/docker:/var/lib/docker dgageot/fiboid 0
docker run --rm --privileged -ti -v /var/lib/docker:/var/lib/docker dgageot/fiboid 1
docker run --rm --privileged -ti -v /var/lib/docker:/var/lib/docker dgageot/fiboid 2
docker run --rm --privileged -ti -v /var/lib/docker:/var/lib/docker dgageot/fiboid 4
```

I've run this container with the value <code>15</code>. It takes 30 minutes on my machine to compute the result. It launches hundreds of Docker containers to do so. The longest depth is 14. Which means that it launches a Docker#14 inside a Docker#13 inside a Docker#12 ... inside a Docker#1.

<blockquote>
  What is it useful for? you might ask
</blockquote>

Well, first it's fun. Then it taught me a lot about Docker. I had to understand what this <a href="https://registry.hub.docker.com/u/jpetazzo/dind/">Dind image from Jérôme Petazzoni</a> does and how it works.

<blockquote>
  You also wonder why it takes so much time when people say that Docker is really fast with almost no CPU overhead.
</blockquote>

Because I spawn Docker containers inside Docker containers, I have to start a fresh Docker daemon almost each time. For each two containers, I spawn one Docker daemon. This is where the time is spent, not in the execution of the containers.
