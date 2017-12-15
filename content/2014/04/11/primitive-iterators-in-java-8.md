---
title: "Primitive Iterators in Java 8"
date: 2014-04-11T12:00:00+01:00
tags: ["java 8","streams"]
---

You all know the difference between <strong>Integer</strong> and <strong>int</strong> in Java? Right? These two ways of working with integers, either as an Object or as a primitive, is the source of much pain. Auto-boxing blurred the differences but there are cases where the JVM cannot get the performance of primitive type with the Object type.

In Java 8, <strong>Stream&lt;T&#62;</strong> was brought to us and lots. But also <strong>IntStream</strong>, <strong>DoubleStream</strong> and <strong>LongStream</strong>. Lots of methods serve as bridges between the two. For example <strong>Stream.mapToInt(ToIntFunction&lt;T&#62;)</strong> transforms a <strong>Stream&lt;T&#62;</strong> into an <strong>IntStream</strong>. Once you step into the world of primitives, you get better performances without the JVM doing clever things.

Java 8 also brought us <strong>OfInt</strong> as a more performant replacement for <strong>Iterator&lt;Integer&#62;</strong>. Here's an example:

```java
OfInt iterator = IntStream.rangeClosed(1, 1000).iterator();
while (iterator.hasNext()) {
    System.out.println(iterator.nextInt()); // not .next() !!
}
```

Of course previous code should be written this way instead:

```java
IntStream.rangeClosed(1, 1000).forEach(System.out::println);
```

It was just to show you how to create an instance of <strong>OfInt</strong>.
