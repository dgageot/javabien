---
title: "Travis CI on a Java project with Docker support"
date: 2015-08-21T12:00:00+01:00
tags: ["docker","sonarqube","travis"]
---

I maintain a couple of [Java projects][github] that use [Travis CI][travis] for automated CI. It's great! I'm also working with [SonarSource][sonarsource] to migrate most of their internal Jenkins to Travis. That's quite a few projects...

**Java build stack on Travis CI**

Most of these projects use the standard `language: java` travis.yml configuration. And it works very well. Java and Maven are installed. Maven dependencies can be cached between builds to speed things up. Lot's of services are available pre-installed in case you need them. For instance, at SonarSource, we use mysql, postgresql, xvfb...

**It's not enough**

However, sometimes you'd like to tweak the environment. Maybe you'd prefer another version of Java or Maven. Or you'd like to install a service that is not white-listed on Travis' infrastructure. Some of those tweaks are not too complicated to achieve. Some are basically not permitted.

**Native Docker support on Travis CI**

When native Docker support [was announced][announce] on Travis blog two days ago, I was very pleased. Like dancing like crazy pleased. This could really be a game changer.

**So I tested a couple of things**

First, I worked on a SonarQube repository that is not a Java project but a Docker project, it hosts the sources for the [official SonarQube images][sonarqube]. Until then, it was not easy to test that our Dockerfiles were valid.

Now it's dead simple. Here's the `travis.yml` that we might end up using:

```yaml
sudo: required

language: bash

services:
  - docker

script:
  - docker build -t sonarsource/sonar-5.1.2 5.1.1
  - docker build -t sonarsource/sonar-4.5.5 4.5.5
  - docker build -t sonarsource/sonar-5.1.1 5.1.1
  - docker build -t sonarsource/sonar-5.1 5.1
  - docker build -t sonarsource/sonar-4.5.4 4.5.4
```

As a **HUGE** bonus, we will be able to `docker run` those images and test them the same way we test our software.

**Let's test something else**

Then, I focused on one of my Java projects to see what could be done. I took [Fluent-http][fluent-http], our kick-ass Java 8 web framework.

The `.travis.yml` looked like this before:

```yaml
language: java

sudo: false

install: true

jdk: oraclejdk8

cache:
  directories:
    - '$HOME/.m2/repository'
```

And I tried to use official [maven docker images][maven] instead. This way, I can choose the java I want, the maven I want. I can make sure I don't rely on anything installed on the Travis host except Docker.

```yaml
language: bash

sudo: required

services:
  - docker

script:
  - docker run -it -v $(pwd):/root/sources -w /root/sources maven:3.3.3-jdk-8 mvn clean install
```

The important thing to remember is that now I can **REPRODUCE** the build on my machine. On any future service that will offer docker support. I feel at the same less tied to TravisCI and very grateful that they offer good docker support.

**Things to improve**

Of course there are still rough edges. The main problem is the lack of caching for both images and local disk. That should improve in a near future.

Have fun!

[github]: https://github.com/CodeStory
[travis]: https://travis-ci.org/
[sonarsource]: https://github.com/SonarSource
[announce]: http://blog.travis-ci.com/2015-08-19-using-docker-on-travis-ci/
[fluent-http]: https://github.com/CodeStory/fluent-http
[maven]: https://hub.docker.com/_/maven/
[sonarqube]: https://hub.docker.com/_/sonarqube/
