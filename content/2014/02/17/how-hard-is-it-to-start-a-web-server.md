---
title: "How hard is it to start a Web Server?"
date: 2014-02-17T12:00:00+01:00
tags: ["code story","java","web"]
---

For <a href="http://www.code-story.net/blog/">Code-Story</a> coding challenge, <a href="http://www.code-story.net/team/jeanlaurent">Jean-Laurent</a> and I have been trying to work with existing web or rest stacks. None was as simple as we wished. Yes you hear me well: none of the bazillions existing web framework was simple enough.

The most simple use case is:
<blockquote>How hard is it to start that damn thing?</blockquote>

We are currently working on our own stack developed with Java 8 : <a href="https://github.com/CodeStory/code-story-http">Code-Story Http</a>. The name is the worst we could come up with and it might change if we ever feel the urge to do so.

With this simple stack, here's how we start a Web server:

Maven configuration:

```xml
<dependency>
  <groupId>net.code-story</groupId>
  <artifactId>http</artifactId>
  <version>1.31</version>
</dependency>
```

Java code:

```java
import net.codestory.http.*;

public class StartAWebServer {
  public static void main(String[] args) {
    new WebServer().start();
  }
}
```

That was hard!

With this code you get a fully functional web server running on port 8080 ,serving files under <code>app</code> folder as static assets. It is able to convert on the fly, server-side, coffee to js, markdown to html, asciidoc to html, less to css. It has a server-side templating engine based on HandleBars. It handles most of the features Jekyll would provide like layouts, includes, yaml based configuration...

If this can be done with so few lines of code, what can be done with the more line? We used java 8 and <a href="http://en.wikipedia.org/wiki/Nashorn_(JavaScript_engine)">Nashorn</a> a lot to make our stack easy to use, yet powerful.

If you are interested, read the <a href="https://github.com/CodeStory/code-story-http/blob/master/README.md">documentation</a> (still under construction)

I'll talk more about this web server in the upcoming days.
