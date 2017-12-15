---
title: "Static methods in Interfaces with Java 8"
date: 2014-03-19T12:00:00+01:00
tags: ["java 8"]
---

<a href="http://mreinhold.org/blog/jdk8-ga">Java 8</a> is here! That was a long wait. I mean for people who like to wait for the thing to be fully released before they even try it. I know a lot of people who even think they need to wait until Java 9 is out to start to use Java 8. For me the wait for a little shorter since I've been using Java 8 for quite some time and even shipped apps with it. Small apps but real apps.

Anyway, let's take a look at one of the new features that I really like. People talked a lot about default methods in interfaces. They are great! Another great thing is static methods in interfaces. I really love those.

<blockquote>
  Before Java 8
</blockquote>

You remember those times where you had a <code>Function</code> interface and a <code>Functions</code> class with a bunch of static methods to create specific implementations of <code>Function</code>? Take a look at Guava code. It uses a lot this pattern. And we used to like it.

<blockquote>
  With Java 8
</blockquote>

Now time has come to merge these two classes. We can put all static methods of <code>Functions</code> back into <code>Function</code> like this:

```java
public interface Function<T, R> {
  R apply(T t);

  static Function<?, String> toStringFunction() {
    return value -> value.toString();
  }

  static <E> Function<E, E> identity() {
    return value -> value;
  }

  static <R> Function<?, R> constant(R constantValue) {
    return value -> constantValue;
  }
}
```
