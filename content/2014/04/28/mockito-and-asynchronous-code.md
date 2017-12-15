---
title: "Mockito and asynchronous code"
date: 2014-04-28T12:00:00+01:00
tags: ["async","mockito"]
---

On Friday, I talked about using Awaitility. It's a good tool to black-box test asynchronous code. You trigger an action and then wait for a predicate to be true.

Another tool I use a lot to test asynchronous code is <a href="https://code.google.com/p/mockito/">Mockito</a>. People tend to forget that Mockito is able to verify calls on a mock with the same kind of polling mechanism as Awaitility.

Here's a code sample:

```java
@Test
public void async() {
  Receiver receiver = mock(Receiver.class);

  Sender sender = new Sender(receiver);
  sender.post("hello");

  verify(receiver, timeout(1000)).onMessage("hello");
}
```

Simple, yet very effective.

<blockquote>
  Mockito is more for white-box testing than Awaitility.
</blockquote>

Also, remember that the easiest way to test asynchronous code is to make it synchronous!
