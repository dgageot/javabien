---
title: "Better Java 8 support in Awaitility"
date: 2014-04-25T12:00:00+01:00
tags: ["awaitility","java 8","tests"]
---

<a href="https://code.google.com/p/awaitility/">Awaitility</a> is a nice library than can be used to easily test asynchronous code.

The idea is to execute some code in your test and then wait for a predicate to be true. It uses polling. A predicates is tested until it is true or a timeout was reached.

Here's a sample test from Awaitility's website:

```java
@Test
public void updatesCustomerStatus() throws Exception {
  // Publish an asynchronous event:
  publishEvent(updateCustomerStatusEvent);

  // Awaitility lets you wait until the asynchronous operation completes:
  await().atMost(5, SECONDS).until(costumerStatusIsUpdated());
}
```

It makes it almost trivial to test multi-threaded code.

Owever, sometimes the syntax of the predicate is a little cumbersome. At least it was until version 1.6.0 of Awaitility. They've added a better support for Java 8.

You can now write something like that:

```java
@Test
public void new_user_is_persisted_to_user_repository() {
  commandPublisher.publish(new CreateUserCommand("John Doe"));

  await().until(userRepo::size, is(1));
  await().until(userRepo::isNotEmpty);
}
```

<blockquote>
  Find out more on their <a href="http://www.jayway.com/2014/04/23/java-8-and-assertj-support-in-awaitility-1-6-0/">blog post</a>
</blockquote>
