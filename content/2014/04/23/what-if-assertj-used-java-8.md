---
title: "What if AssertJ used Java 8"
date: 2014-04-23T12:00:00+01:00
tags: ["assertj","java 8"]
---

If you write tests for your java code, there's a chance you use <a href="https://github.com/alexruiz/fest-assert-2.x">Fest-Assert</a> or <a href="http://joel-costigliola.github.io/assertj/">AssertJ</a>.

<blockquote>
  If you don't know AssertJ, go test it.
</blockquote>

Getting addicted is as easy as writing a first test with it. Here's a sample test you might write today, just after you close this blog post:

```java
import static org.assertj.core.api.Assertions.*;
import java.util.*;
import org.junit.*;

public class CollectionsSort {
  @Test
  public void sort() {
    List cities = Arrays.asList("Paris", "Berlin", "Rome");
    Collections.sort(cities);

    assertThat(cities).containsExactly("Berlin", "Paris", "Rome");
  }
}
```

<code>org.assertj.core.api.Assertions</code> implements the typical <code>garbage class</code> pattern. It contains a lot of static <code>assertThat</code> methods that we don't know where to put otherwise.

<blockquote>
  Let's see if Java 8 can improve the way we write tests.
</blockquote>

With Java 8, <code>Assertions</code> could be an interface. With static methods only. And I would write:

```java
import java.util.*;
import org.assertj.core.api.Assertions.*;
import org.junit.*;

public class CollectionsSort implements Assertions {
  @Test
  public void sort() {
    List cities = Arrays.asList("Paris", "Berlin", "Rome");
    Collections.sort(cities);

    assertThat(cities).containsExactly("Berlin", "Paris", "Rome");
  }
}
```

Where's the difference? Instead of using a static import, the test case inherits some assertions methods. No fields. Only static methods. This way, developers won't forget to replace <code>Assertions.assertThat(...)</code> with replace <code>assertThat(...)</code>.

<blockquote>
  Not convinced? Look at this test:
</blockquote>

```java
@Test
public void names() {
  List cities = Arrays.asList(new City("Paris"), new City("London"));

  assertThat(cities).extracting("name").containsExactly("Paris", "London");
}
```

It could leverage Java 8 method references like this:

```java
@Test
public void names() {
  List cities = Arrays.asList(new City("Paris"), new City("London"));

  assertThat(cities).extracting(City::getName).containsExactly("Paris", "London");
}
```

This last example could be implemented right now in AssertJ. It would use inner classes in Java 7 and lambdas in Java 8.
The first example is trickier. It cannot be compatible with anything else than Java 8.

<blockquote>
  Anyway, expect librairies to embrace Java 8 patterns in the future.
</blockquote>
