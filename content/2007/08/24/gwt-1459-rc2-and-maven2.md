---
title: "GWT 1.4.59-RC2 and Maven2"
date: 2007-08-24T12:00:00+01:00
tags: ["gwt","maven"]
---

<a href="http://code.google.com/webtoolkit/download.html#rc">Gwt 1.4.59-RC2</a> was just released. If you use Maven2 to build your project, this latest version can be found on <a href="http://maven.xi8ix.org/">xi8ix repository</a>.

Here is the configuration:

```xml
<repositories>
  <repository>
    <id>xi8ix</id>
    <url>http://maven.xi8ix.org/</url>
  </repository>
</repositories>
<dependency>
  <groupId>com.google</groupId>
  <artifactId>gwt-user</artifactId>
  <version>1.4.59-RC2</version>
  <scope>provided</scope>
</dependency>
<dependency>
  <groupId>com.google</groupId>
  <artifactId>gwt-servlet</artifactId>
  <version>1.4.59-RC2</version>
</dependency>
```

I had to tweak a few things in my [SpringDispatchService]({{< relref "2007/08/07/spring-and-gwt-integration.md" >}}). Maybe it's time to find a more stable solution...
