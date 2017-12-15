---
title: "Get parameter names in Java 8"
date: 2014-04-24T12:00:00+01:00
tags: ["java 8"]
---

Before Java 8, it was very difficult to get parameter names at runtime. For example, Spring's <code>@PathVariable</code> annotation needs you to either repeat the name of the annotated parameter like this:

```java
public String findOwner(@PathVariable("ownerId") String ownerId) {
}
```

Or, make sure the code is compiled with debug information and let Spring do some black magic with this information. You can then remove some duplication in your code:

```java
public String findOwner(@PathVariable String ownerId) {
}
```

With Java 8, parameter names can be retrieved at runtime with this code:

```java
String name = String.class.getMethod("substring", int.class).getParameters()[0].getName()
System.out.println(name);
```

<blockquote>
  WAIT! It prints <code>arg0</code>, not <code>beginIndex</code> !!!
</blockquote>

Well it turns out that parameters names are still not activated by default. You have to compile your code with <code>-parameters</code> javac command line option.

<blockquote>
  Why is it not activated by default. That's beyond me.
</blockquote>

At least, it removes some dark magic out of the process.
