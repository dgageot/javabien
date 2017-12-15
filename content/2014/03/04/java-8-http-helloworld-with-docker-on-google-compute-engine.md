---
title: "Java 8 http HelloWorld with docker on Google Compute Engine"
date: 2014-03-04T12:00:00+01:00
tags: ["google","gce","docker","java 8"]
---

I tried to put more buzzwords in the title of this blog post but didn't succeed... So anyway, let's see what's really behind these buzzwords.

With this article my goal is to host on <a href="https://cloud.google.com/products/compute-engine/">Google Compute Engine</a> (GCE) a basic java http server that will answer "Hello World".

<blockquote>
  "Use the Api Luke!"
</blockquote>

I want to do as much as possible using GCE's Api because this Api is a big deal. Not all cloud providers give us such a nice tool to automate thing.

<blockquote>
  "Docker fear you should not"
</blockquote>

And to make things more interesting, I'll use <a href="https://www.docker.io/">docker</a> to describe the process that will run on my GCE instance. I'd like to keep the configuration on the instance as minimal as possible. Everything should be configured inside a docker container so that I can test it on my local machine too.

<blockquote>
  Let's start with Google Compute Engine
</blockquote>

First, I need to install the GCE command line Api:

```bash
$ brew install gcutil
```

Then, I should create a GCE account. Mine is already created. I've got a project named <strong>code-story-blog</strong>.

<blockquote>
  Start a new instance
</blockquote>

Let's create and start a simple instance that we are going to call <strong>master</strong>.

```bash
$ gcutil --project="code-story-blog" addinstance "master" --zone="europe-west1-a" --machine_type="n1-standard-1" --image="https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/backports-debian-7-wheezy-v20131127"

+--------+----------------+---------------+----------------+---------+
| name   | network-ip     | external-ip   | zone           | status  |
+--------+----------------+---------------+----------------+---------+
| master | 10.240.205.130 | 23.251.132.99 | europe-west1-a | RUNNING |
+--------+----------------+---------------+----------------+---------+
```

Now that our instance is up and running, let's ssh to install docker.

<blockquote>
  Connect with ssh
</blockquote>

```bash
$ gcutil --project="code-story-blog" ssh master

$ curl get.docker.io | bash

Docker has been successfully installed!
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

$ sudo usermod -aG docker `whoami`
$ exit
$ gcutil --project="code-story-blog" ssh  master
```

<a href="http://docs.docker.io/en/master/installation/google/">Source</a>

<blockquote>
  Let's build a docker image
</blockquote>

Now almost everything is ready to build a docker image on the instance. I've prepared a <a href="https://github.com/dgageot/helloworld">GitHub repository</a> that contains the <strong>Dockerfile</strong> that describes my setup. To grab it, docker needs git. So let's install git. That is the last thing I will install on the instance. The rest will be done inside the docker container.

<blockquote>
  Install git
</blockquote>

```bash
$ sudo apt-get install -y git
```

<blockquote>
  The image descriptor
</blockquote>

Here's what the <a href="https://github.com/dgageot/helloworld/blob/master/Dockerfile">Dockerfile</a> looks like is you are too lazy to click on the link. Basically, what it does is:

 + Start from an ubuntu base
 + Install some prerequisite tools
 + Setup the source for java 8 packages
 + Install Java 8
 + Install Git and Maven
 + Clone my hello world project
 + Build the project using maven
 + Tell that it's going to run something on port 8080
 + Tell that it will run inside the helloworld directory

My idea is to clone a java 8 project, build it inside the container with maven. Run it.

The Dockerfile:

```bash
from base

# Install prerequisites
run apt-get update
run apt-get install -y software-properties-common

# Install java8
run add-apt-repository -y ppa:webupd8team/java
run apt-get update
run echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
run apt-get install -y oracle-java8-installer

# Install tools
run apt-get install -y git maven

# Clone project
run git clone https://github.com/dgageot/helloworld.git

# Build project
run cd helloworld &amp;&amp; mvn verify dependency:copy-dependencies

# Expose the http port
expose 8080

workdir helloworld
```

<blockquote>
  Let's build the image and drink a couple of coffees!
</blockquote>

```bash
$ docker build -t dgageot/helloworld github.com/dgageot/helloworld
```

The slowest part of the installation is the part that installs Java 8. You'll see <code>Saving to: jdk-8-fcs-bin-b129-linux-x64-07_feb_2014.tar.gz</code> for quite some time. It's OK.
So, after the coffee break, we now have a fully prepared docker image. Let's check that it's properly working by running it.

<blockquote>
  Verify
</blockquote>

```bash
$ docker run -i -t dgageot/helloworld java -version
```

It should tell us that java 8 is installed. That's nice! Let's run the web server now.

<blockquote>
  Run
</blockquote>

With this command, I tell docker to use the image to run my java application. It will use the sources that was cloned during the image construction. The application is running an http server on port 8080 and I tell docker that this port should be mapped to my host's 80 port.

```bash
$ docker run -p 80:8080 -t -i dgageot/helloworld java -DPROD_MODE=true -jar target/helloworld-1.0-SNAPSHOT.jar

$ curl http://localhost/
Hello World
```

<blockquote>
  Make it visible from outside the host
</blockquote>

Ok. It works on my instance. But can we see the web pages from the outside? Not yet, GCE will block the 80 port. We have to add a firewall rule that will allow traffic on port 80. The api is our friend:

```bash
$ gcutil --project="code-story-blog" addfirewall samplehttp --description="Incoming http allowed." --allowed="tcp:http"
```

From my laptop:

```bash
$ curl http://23.251.132.99/
Hello World
```

Here we are! We started a very simple Java 8 hello world on Google Compute Engine using docker. hence the buzzwords in the title.

If we want to stop the instance, let's tell it to poweroff. It will kick us out of ssh.

```bash
sudo poweroff
```

And now we just have to really delete the instance to go back to were we started.

```bash
gcutil --project="code-story-blog" deleteinstance master
```

If you followed this tutorial and tried to delete your instance, gcutil will ask you if you want to keep the disk attached to the <code>master</code> instance. You can skip its deletion because tomorrow we are going to use this persisted state to start a lot of clones running the same helloword.

<blockquote>
  Stay tuned!
</blockquote>
