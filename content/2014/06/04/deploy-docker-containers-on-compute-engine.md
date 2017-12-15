---
title: "Deploy Docker containers on Compute Engine"
date: 2014-06-04T12:00:00+01:00
tags: ["docker","gcp"]
---

Three months ago, I posted on this blog a
[tutorial]({{< relref "2014/03/04/java-8-http-helloworld-with-docker-on-google-compute-engine.md" >}}) that teaches how to deploy on Google Compute Engine a Java 8 application packaged in a Docker container.

As Docker is getting more and more traction, Google now let us deploy Docker containers on Compute Engine instances, at creation time. It leverages two things that are not new:

<blockquote>
  Compute Engine can run a VM with Docker pre-installed
</blockquote>

An new stock VM image is provided by Google. Its full path is <code>projects/google-containers/global/images/container-vm-v20140522</code>. It's a bare Debian VM whose sole purpose is to start Docker containers.

Right now it doesn't look like it's as small as <a href="https://github.com/boot2docker/boot2docker">boot2docker</a> or <a href="https://github.com/unclejack/debian2docker">debian2docker</a>. For example <code>apt-get</code> is installed but shouldn't be useful since you only want to run containers. Also there are twice as many commands in the path as on a boot2docker.

<blockquote>
  Metadata are used by the VM a creation time
</blockquote>

When you create the instance, if you pass a yaml file that contains metadata, these metadata can be used by the VM to perform some setup work at creation time.

That's exactly how you deploy Docker containers at creation time. You write a yaml file like this one:

```yaml
version: v1beta1
containers:
  - name: helloworld
    image: dgageot/helloworld
    command: ['java', '-jar', 'target/hello.jar']
    ports:
      - name: http
        hostPort: 80
        containerPort: 8080
```

And you create a new instance with a command like this one:

```bash
gcloud compute instances create NAME --image projects/google-containers/global/images/container-vm-v20140522 --metadata-from-file google-container-manifest=containers.yaml --zone europe-west1-b --machine-type n1-standard-1 --tags=http-server
```

And once the vm is created, it will automatically pull <code>dgageot/helloworld</code> container from <a href="https://index.docker.io/u/dgageot/helloworld/">Docker Index</a> and start the container with the given port forwarding configuration.

Of course, it's possible to deploy many containers on the same vm. That's the beauty of it!

<blockquote>
  Have fun!
</blockquote>
