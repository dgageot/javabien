---
title: "A web server for your tests"
date: 2014-02-18T12:00:00+01:00
tags: ["java","tests"]
---

Let's say you're writing some code that makes http calls. And you'd like to write an integration test to secure your code.

<blockquote>How would you start a web server that serves only what you need for your test?</blockquote>

Wait... That's easy, you'd use the web server I talked to you about [yesterday]({{< relref "2014/02/17/how-hard-is-it-to-start-a-web-server.md" >}})!

```java
import net.codestory.http.*;

public class IntegrationTest {
  @Test
  public test() {
    new WebServer(routes -> routes.get("/uri", "Hello")).start();

    ... Connect to the server on port 8080
  }
}
```

This piece of code starts an http server that answers <code>Hello World</code> when somebody sends a GET request on port 8080.

<blockquote>One line of code that's nice!</blockquote>

If you, like me, tend to run your tests in parallel, starting a web server on port 8080 will be a problem. You'd be tempted to find a free port using some kind of <a href="http://stackoverflow.com/questions/3265825/finding-two-free-tcp-ports">ServerSocket</a> trick. But that's not completely bulletproof. Just change your code this way and you're done:

```java
int thePort = new WebServer(routes -> routes
  .get("/uri", "Hello")).startOnRandomPort();

... Connect to the server on port 'thePort'
```

Under the hood, it chooses a random port, tries to bind it and if there's a problem, retries with another port. That is bulletproof.

Ok, now what if you expect a json response and not a simple Hello String? Easy as <del>pie</del> bean.

```java
new WebServer(routes -> routes
  .get("/uri", new MyBean())).startOnRandomPort();
```

<code>MyBean</code> is automatically serialised to json using <a href="http://jackson.codehaus.org/">Jackson</a>.

Now, you have no excuse to not test your code that consumes content from a web server. Oh and I forgot to tell you that the server starts in less than 300ms, so you can use and abuse.
