---
title: "A Better Boot2Docker on OSX"
date: 2014-06-05T12:00:00+01:00
tags: ["docker","osx"]
---

Boot2docker is the official way of running Docker on OSX. It's working very well. That is until you want to forward ports or share volumes with your host. I mean the real host, the OSX, not boot2docker's VM.

Well, things will get better soon. Boot2docker's trunk contains new features/documentation that'll make it more transparent to use Docker on a Mac.

Instead of <a href="https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md">mapping virtual box's ports to OSX's ports</a>, you might find it easier to use <code>boot2docker ip</code> to get boot2docker's IP and use this IP instead of localhost. It's not perfect but it's simple.

Also it's very difficult to mount a local OSX folder. If possible at all. A nice workaround is to use a file sharing Docker container like <code>svendowideit/samba</code> to make a boot2docker folder visible on OSX through Samba.

Be prepared for the 'There's a Docker container for that' meme.

More information on <a href="https://github.com/boot2docker/boot2docker">boot2docker</a>'s Github.
