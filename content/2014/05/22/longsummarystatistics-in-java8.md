---
title: "LongSummaryStatistics in Java8"
date: 2014-05-22T12:00:00+01:00
tags: ["java 8","streams"]
---

Java Streams are a powerful tool to get rid of boilerplate code. One has never computed the min, max, average and count on a list of longs?

Here's a way to do it with <code>LongSummaryStatistics</code>

```java
LongSummaryStatistics stats = persons.stream().mapToLong(Person::getAge).summaryStatistics();

System.out.println(stats.getCount());
System.out.println(stats.getAverage());
System.out.println(stats.getMin());
System.out.println(stats.getMax());
```
