---
title: "Better Docker on OSX with docker-machine, boot2docker and VMware"
date: 2015-08-20T12:00:00+01:00
tags: ["boot2docker","docker"]
---

I'm on OSX and work a lot with Docker. I've always found [boot2docker][boot2docker] on VirtualBox OK enough to the extent that it was not worth spending time making Docker run on VMware Fusion instead. Even if performances are better. Specially on shared folders.

Well, until now. Docker Machine to the rescue!

![docker machine][docker-machine-logo]

The new preferred way to install Docker on a Mac is to use [Docker Toolbox][toolbox]. Toolbox is using [Docker Machine][docker-machine] to provision the boot2docker VM on VirtualBox.

Under the hood, what it does is run this simple command:

```bash
docker-machine create --driver=virtualbox default
```

So, using VMware Fusion (version 7+) is as simple as deleting the *default* machine and recreating it with:

```bash
docker-machine rm default
docker-machine create --driver=vmwarefusion default
```

That's was easy!

It might also be a good idea to configure the amount of CPU, disk and memory you allocate to this VM:

```bash
docker-machine create --driver vmwarefusion --vmwarefusion-cpu-count 2 --vmwarefusion-disk-size 80000 --vmwarefusion-memory-size 4096 default
```

Have fun!

[boot2docker]: http://boot2docker.io/
[toolbox]: https://www.docker.com/toolbox
[docker-machine]: https://docs.docker.com/machine/
[docker-machine-logo]: /images/docker-machine.png#center "Docker Machine"
