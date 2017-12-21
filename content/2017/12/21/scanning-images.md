---
title: Scanning Vulnerabilities in Docker images
date: 2017-12-21T09:35:00+01:00
tags: ["docker","google","security scanning","java", "cve"]
---

Part of the value proposition of Containers is improved security. By running
services inside containers, one can reduce the attack surface of an application.

To properly reduce the attack surface, great care must be given to the choice
of base images. It's very common to see Dockerfiles based on super-heavy base
images that the application won't need.

> Multi-stage builds

Docker [multi-stage](https://docs.docker.com/engine/userguide/eng-image/multistage-build/)
builds help a lot in that matter by letting you use heavy images to build apps
but prefer tiny images to actually run them. Go try [Google Container Builder](https://cloud.google.com/container-builder/)! It supports multi-stage
builds.

Here's a canonical example of multi-stage build for a Java application. Maven
and a JDK are used to build the app. However, only the JRE is needed to run it.

```docker
FROM maven:3.5-jdk-8
WORKDIR /app
ADD . ./
RUN mvn package

FROM openjdk:8u151-jre-alpine
ADD --from=0 /app/target/app.jar .
CMD ["java", "-jar", "app.jar"]
```

> How to choose a base image?

Choosing a base image is not easy. Beginners usually copy-paste samples at the
risk of using outdated images.

Also because [naming things is hard](https://martinfowler.com/bliki/TwoHardThings.html) some images have
misleading names on the [Docker Store](https://store.docker.com/). Eg. for Java
developers, using the [java](https://store.docker.com/images/java)
base image is tempting. **PLEASE DON'T**. These images are deprecated, haven't been
updated for 10 months and are full of vulnerabilities which defeats the purpose
of reducing the attack surface. It's documented but still, it requires to RTM.

> Vulnerability Scanning

I ran [Google Container Registry Vulnerability Scanning](https://cloud.google.com/container-registry/docs/vulnerability-scanning)
(currently in Alpha) on multiple Java images to compare the known
vulnerabilities in each.

Here's the top 6 vulnerabilities found on the `java:latest` image:

![Vulnerabilities in java base image](/images/scan/java.png)

Choosing the `openjdk:latest` is safer:

![Vulnerabilities in openjdk base image](/images/scan/openjdk.png)

Even better is choosing the `openjdk:8u151-jre-alpine` flavor. Woot!
Kudos to [Natanael Copa](https://twitter.com/n_copa?lang=en) for taking such
good care of Alpine!

![Vulnerabilities in openjdk jre alpine](/images/scan/alpine.png)

> Common Vulnerabilities and Exposures (CVEs)

By the way, for this blog post, I compared the results of [Container Registry Vulnerability Scanning](https://cloud.google.com/container-registry/docs/vulnerability-scanning)
and Docker's own [Security Scanning](https://hub.docker.com/r/library/openjdk/tags/).
As one would expect, the results are very similar since it's ultimately using
the same source for [CVEs](https://cve.mitre.org/index.html).

Sometimes Docker's seems to raise vulnerabilities that are actually fixed. For
example, it raises the
[CVE-2017-15874](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-15874)
on [alpine:3.7](https://hub.docker.com/r/library/alpine/tags/3.7/). Looking at
the [alpine packages list](https://pkgs.alpinelinux.org/package/v3.7/main/x86_64/busybox),
we see that `alpine`&#8239;`3.7` is using `Busybox`&#8239;`1.27.2-r7` that's immune to the CVE
as the [list of patches](https://git.alpinelinux.org/cgit/aports/tree/main/busybox) shows.

**Go scan your images!**
