---
title: "Deep stubbing in Mockito"
date: 2010-01-19T12:00:00+01:00
tags: ["mockito","tdd"]
---

Next version of Mockito, my favorite mocking/stubbing framework, <a href="http://code.google.com/p/mockito/source/detail?r=1816">will provide deep stubbing</a>. This kind of test code will become possible:

``java
@Test
public void canStubOneLevelDeep() {
    OutputStream out = new ByteArrayOutputStream();

    SocketFactory socketFactory = mock(SocketFactory.class, RETURNS_DEEP_STUBS);
    when(socketFactory.<strong>createSocket().getOutputStream()</strong>).thenReturn(out);

    assertThat(socketFactory.createSocket().getOutputStream()).isSameAs(out);
}
```

Notice the two chained calls in a when clause. Isn't it cool? I think that's cool.

I can make tests clearer in case of poorly designed production code. And who doesn't write poorly designed code sometimes? I do more often than not. So why not have <strong>at least</strong> clearer tests?

It would be even cooler if we could get rid of the ulgy (very ugly?) RETURNS_DEEP_STUBS artefact and let the when clause sort things out on its own.

Hey, have you noticed I use <a href="http://fest.easytesting.org/assert/wiki/pmwiki.php">Fest Assert</a>, the best assertion library?
