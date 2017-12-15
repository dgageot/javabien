---
title: "Upgrade docker and boot2docker on OSX"
date: 2014-03-17T12:00:00+01:00
tags: ["boot2docker","docker","osx"]
---

If you followed my [tutorial]({{< relref "2014/03/03/setup-docker-on-osx-the-no-brainer-way.md" >}}) on how to install docker and boot2docker on OSX, a week ago, you now have old versions of both on your machine. Trying to upgrade I encountered a small glitch. So let me share it with you.

First let's upgrade docker and boot2docker:

```bash
$ brew update
$ brew upgrade docker
$ brew upgrade boot2docker
```

Now it's very important to upgrade boot2docker's image otherwise you'll see this kind of message when you try to create new images:

<blockquote>
  Error: Multipart upload for build is no longer supported. Please upgrade your docker client.
</blockquote>

See <a href="https://github.com/dotcloud/docker/issues/4597">this issue</a>

So let's upgrade boot2docker's image:

```bash
$ boot2docker stop
$ boot2docker delete
$ boot2docker download
$ boot2docker init
$ boot2docker up
```

Sometimes boot2docker won't stop. I've had to manually shutdown the vm with VirtualBox's GUI.
