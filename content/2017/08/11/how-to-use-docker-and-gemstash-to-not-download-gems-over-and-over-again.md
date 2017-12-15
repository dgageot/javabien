---
title: "How to use Docker and gemstash to not download Gems over and over again"
date: 2017-08-11T12:00:00+01:00
tags: ["docker","rails"]
---

Using [Docker](https://www.docker.com/) for [Rails](http://rubyonrails.org/) development is an obvious fit now. But it doesn't come with only advantages. One of the most valid counter argument is the fact that you'll download gems over and over again from Internet.

Even if your Dockerfile is written with these [Best Practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/) in mind, you end up downloading **every** gem each time one is added to the `Gemfile`.

This post explains how to use [gemstash](https://github.com/bundler/gemstash) running in a *sidecar* container to ease that pain.

> Run gemstash in a container

[Gemstash](https://github.com/bundler/gemstash) helps you run a cache or private gem server. We are going to use it as a proxy to `rubygems.org`.

Here's the two commands you'll need to run gemstash in a container:

```bash
cat <<EOF | docker build -t gemstash -
FROM ruby:2.4.1

RUN gem install --no-ri --no-rdoc gemstash

EXPOSE 9292
VOLUME /root/.gemstash

ENTRYPOINT ["gemstash"]
CMD ["start", "--no-daemonize"]
EOF

docker run -d --name gemstash -v $(PWD)/gemstash:/root/.gemstash -p 9292:9292 gemstash
```

> Change your app's Dockerfile to use gemstash

Here's the line that you should add to your existing Dockerfile to use gemstash as a proxy to `rubygems.org`:

```docker
FROM ...

RUN bundle config mirror.https://rubygems.org http://docker.for.mac.localhost:9292
...

RUN bundle install
```

We tell `bundle` to connect to `docker.for.mac.localhost` for it now runs a rubygems proxy. Now, `docker build` will point at gemstash and all subsequent builds will be much faster.

FYI `docker.for.mac.localhost` is the *magic* hostname that makes your containers connect to your Mac. On Windows, replace `docker.for.mac.localhost` with `docker.for.windows.localhost`.

> Or use docker build --network

Another (maybe cleaner) way of achieving the same goal without using `docker.for.mac.localhost` special hostname is to run the `gemstash` container on a specific docker network and run `docker build` with a `--network` flag:

```bash
docker network create rails
docker run -d --name gemstash -v $(PWD)/gemstash:/root/.gemstash --network rails gemstash
```

The modification to your Dockerfile will then be:

```docker
RUN bundle config mirror.https://rubygems.org http://gemstash:9292
```

This solution is more portable that using `docker.for.mac.localhost` special hostname. Also, it makes the gemstash container and the build container communicate directly without going through Docker for Mac's vpnkit-based proxy.
