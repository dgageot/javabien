---
title: "Logback can hurt your startup time"
date: 2014-02-21T12:00:00+01:00
tags: ["java","logback","performances","slf4j"]
---

<blockquote>What's the difference between this:</blockquote>

```java
public class Main {
  public static void main(String[] args) {
    long start = System.currentTimeMillis();
    new WebServer().start();
    long end = System.currentTimeMillis();
    System.out.println(end - start);
  }
}

Output:
23:08:57.096 INFO  net.codestory.http.WebServer - Server started on port 8080
389
```

<blockquote>And that:</blockquote>

```java
public class Main {
  public static void main(String[] args) {
    long start = System.currentTimeMillis();
    new WebServer().start();
    long end = System.currentTimeMillis();
    System.out.println(end - start);
  }
}

Output:
130
[main] INFO net.codestory.http.WebServer - Server started on port 8080
```

Exactly! The second program starts three times faster! And I didn't have to change or add a single line of code!

<blockquote>Let me tell you the whole story</blockquote>

I was trying to reduce the startup time of my <a href="https://github.com/CodeStory/code-story-http">Web Server</a>. Because, you know, I thought starting up in 300ms was lame. So I ran my sample code with good old <code>-verbose:class</code> jvm parameter. Turns out the jvm had to load 1626 classes to start the server. Out of which, 240 are <code>ch.qos.logback.*</code> classes. And lot's of xml related classes are loaded. I can swear I don't do xml. Not me!

<blockquote>What if the simple fact of parsing a logback.xml was the reason for my web server being so slow to start?</blockquote>

Let's delete logback.xml file. Easy! 1247 classes are loaded now. That's 379 classes to parse an xml file... I won't comment much on that although there would be much to write about. More important, the startup time went from 389ms down to 217ms. And the logs are still there in the console.

<blockquote>Now what if I don't use logback at all but use slf4j-simple.jar instead?</blockquote>

Now, 1040 classes are loaded and the startup time is down to 130ms. That's better!

As a plus side, I'm free to use whichever slower implementation of slf4j in production. But during development, every 100ms is important.
