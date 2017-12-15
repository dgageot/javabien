---
title: "Setup docker on OSX, the no-brainer way"
date: 2014-03-03T12:00:00+01:00
tags: ["docker","homebrew","osx"]
---

I'm working on a couple of blog posts that explain how to use docker on Google Compute Engine. As an appetizer, here's how I installed <a href="https://www.docker.io/">docker</a> 0.8.0 on OSX, the no-brainer way:

<blockquote>
  First, install Homebrew
</blockquote>

If it's not done already, install <a href="http://brew.sh/">Homebrew</a>. You won't regret it. It is as simple as that:

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

<blockquote>
  Install Virtualbox
</blockquote>

With Homebrew, it's trivial to install Virtualbox which is a prerequisite to running docker on OSX:

```bash
brew update
brew tap phinze/homebrew-cask
brew install brew-cask
brew cask install virtualbox
```

<blockquote>
  Install boot2docker
</blockquote>

Boot2docker is a small script that helps download and setup a minimal Linux VM that will be in charge of running docker daemon.

```bash
brew install boot2docker
boot2docker init
boot2docker up
export DOCKER_HOST=tcp://localhost:4243
```

<blockquote>
  Install docker
</blockquote>

```bash
brew install docker
docker version
```

Done!

More information can be found on docker's official <a href="http://docs.docker.io/en/latest/installation/mac/">documentation</a> and on <a href="https://github.com/boot2docker/boot2docker">boot2docker's github</a>. It includes, setting up port forwarding, folder sharing, explaining why we need boot2docker...

Now, enjoy!
