---
title: "LoadingCache in Java 8 without Guava"
date: 2014-02-20T12:00:00+01:00
tags: ["cache","guava","java 8"]
---

Since <a href="https://code.google.com/p/guava-libraries/">Guava</a> library was released, I've been a huge fan of MapMaker, later renamed to <a href="https://code.google.com/p/guava-libraries/wiki/CachesExplained">CacheBuilder</a>. The feature I prefer is the LoadingCache.

Here's an extract from Guava's wiki:

```java
LoadingCache<Key, Graph> graphs = CacheBuilder.newBuilder()
       .build(
           new CacheLoader<Key, Graph>() {
             public Graph load(Key key) throws AnyException {
               return createExpensiveGraph(key);
             }
           });
```

Basically, what it does is instantiate a ConcurrentHashMap that computes its values on demand. Call <code>graps.get(aKey)</code> and the <code>load(key)</code> method will be invoked with <code>aKey</code> in argument. The resulting value will be stored into the Map. Next time <code>graps.get(aKey)</code> is called, the value will be returned directly from the cache. That's nice! All this completely thread safe!

With <a href="https://jdk8.java.net/download.html">Java 8</a>, you can do the same with a very elegant syntax:

```java
ConcurrentMap<Key, Graph> map = new ConcurrentHashMap<>();
map.computeIfAbsent(aKey, key -> createExpensiveGraph(key));
```

Nice isn't it?

The second argument is a lambda that tells the map how to create the value from a key. Unlike inner classes, using a lambda adds no noticeable cost to the method call.

It's not as good as the CacheBuilder in terms of expiry management, yet it's really simple and nice to use.
