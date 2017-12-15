---
title: "Java 8 - FooBarQix - ListMaker"
date: 2012-11-29T12:00:00+01:00
tags: ["guava","java 8"]
---

You might be familiar with the <strong>FooBarQix</strong> kata. Last year the CodeStory team used this kata for the first selection round of the challenge. You can read a few submissions <a href="http://code-story.net/2011/12/22/bravo.html">here</a> (French).

Here are the rules:

<pre>
Given an integer:
 * If it's divisible by 3 then write "Foo"
 * If it's divisible by 5 then write "Bar"
 * If it's divisible by 7 then write "Qix"
 * If it contains digit 3, replace digit by "Foo"
 * If it contains digit 5, replace digit by "Bar"
 * If it contains digit 7, replace digit by "Qix"
</pre>

Here's what I wrote with Java 8:

```java
String[] codes = {"", "", "", "Foo", "", "Bar", "", "Qix", "", ""};

String fooBarQix = with(3, 5, 7)
  .only(divisor -> (n % divisor) == 0)
  .concat(n / 100, (n % 100) / 10, n % 10)
  .map(v -> codes[v])
  .join();

return fooBarQix.isEmpty() ? n.toString() : fooBarQix;
```

To be honest, this is not plain java 8 code. It uses the library <strong>ListMaker</strong> I started to write in 2008 to test-drive "functional programming" in Java with Guava. It is available on <a href="http://search.maven.org/#search%7Cga%7C1%7Clistmaker">Maven Central</a>. Feel free to use it and improve it.

It is very similar to Java 8's <strong>Streams</strong> or Guava's <strong>FluentIterable</strong> introduced a couple of versions back. But I find <strong>ListMaker</strong> more complete and less verbose. Tell me what you think.
