---
title: "Why do we have to play with keystores to start an https server?"
date: 2014-04-02T12:00:00+01:00
tags: ["fluent-http","ssl","web"]
---

If you develop in Java and want to start an http<strong>S</strong> server, more often than not, you end up trying to understand how to put your certificates into a keystore. That's a lot of frustration.

If you know <a href="http://nginx.org/">nginx</a>, the configuration for an SSL proxy is so simple:

```java
server {
    listen 443;
    ssl on;
    ssl_certificate /etc/nginx/keys/domain.crt;
    ssl_certificate_key /etc/nginx/keys/domain.key;

    location / {
        proxy_pass http://localhost:8080;
    }
}
```

<blockquote>
  Why the hell can't we do the same simple thing in Java?
</blockquote>

That'd be so nice to just give those two files, the certificate and the key, and let the web server work things out.

That's exactly what I've implemented in <a href="https://github.com/CodeStory/fluent-http">fluent-http</a>. Here's the code to start an http server:

```java
import net.codestory.http.*;

public class HelloWorld {
  public static void main(String[] args) {
    new WebServer().start();
  }
}
```

Here's the code to start an https server:

```java
import net.codestory.http.*;

public class HelloWorld {
  public static void main(String[] args) {
    new Webserver().startSSL(9443, Paths.get("server.crt"), Paths.get("server.der"));
  }
}
```

<blockquote>
  Can you spot the differences?
</blockquote>
