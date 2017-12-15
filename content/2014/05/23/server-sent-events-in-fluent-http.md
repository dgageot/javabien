---
title: "Server-sent events in fluent-http"
date: 2014-05-23T12:00:00+01:00
tags: ["fluent-http"]
---

Today, I've added the initial support of <a href="http://en.wikipedia.org/wiki/Server-sent_events">Server-sent events</a> in <a href="https://github.com/CodeStory/fluent-http">fluent-http</a>.

The underlying http server we use (<a href="http://www.simpleframework.org/">Simple</a>) doesn't support websockets yet. But streaming good-old server-sent events works very well.

To produce a stream of messages, we rely on the Java 8 Stream API.

<blockquote>
  Here's a sample
</blockquote>

```java
new WebServer(routes -> routes
        .get("/events", () -> Stream.iterate(0, (a) -> a + 1)))
        .start(9090);
```

This code streams the values 0,1,2,3,4,5... for ever.

<blockquote>
  Have fun!
</blockquote>
