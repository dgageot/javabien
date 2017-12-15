---
title: "Size of Docker images: Which linux is smaller?"
date: 2014-06-18T12:00:00+01:00
tags: ["docker"]
---

Docker images are composed of layers. When you pull an image, only the layers you haven't yet in cache are retrieved.

That means that if you use multiple images based on the same base Operating System, the base layer is created or retrieved only once. So the size of this layer is not really important.

However if you have to export a container to a tar file, the size matters. Or if you pull an image from a fresh machine, here again it matters which OS you choose as a base to your Dockerfile.

I exported both a <code>google/debian:wheezy</code> and an <code>ubuntu:14.04</code> containers to tar files using <code>docker export</code>.

```bash
docker export $(docker run -d google/debian:wheezy true) > debian.tar
docker export $(docker run -d ubuntu:14.04 true) > ubuntu.tar
```

The debian container is 123MB.
The ubuntu container is 255MB. (+132MB)

I also built the <a href="https://github.com/dgageot/ngxpagespeed">same project</a>, an nginx compiled with spdy and pagespeed, with both a debian base and an ubuntu base.

The debian based container is 306MB.
The ubuntu based container is 407MB. (+101MB)

<blockquote>
  Size matters.
</blockquote>
