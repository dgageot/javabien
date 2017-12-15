---
title: "Simplelenium, writing robust tests with Selenium"
date: 2014-04-15T12:00:00+01:00
tags: ["selenium"]
---

I use <a href="http://docs.seleniumhq.org/">Selenium</a> a lot. And I hate it! I hate it and I use it. Every other browser automation tool I've used either has the same problems as Selenium or end up dying because nobody uses it. There are nice librairies to make writing Selenium tests more user friendly. <a href="https://github.com/FluentLenium/FluentLenium">Fluentlenium</a> is one of those nice tools. But Selenium's problem is not really with its syntax. <strong>It's the complexity of writing stable tests</strong>. It's hell!

<blockquote>
  It would be great if Selenium tests didn't fail every other day
</blockquote>

If you test modern websites with Selenium, you end up playing with waits and timers. Very often people put random Thread.sleep(s) into their test code because they are just fed up trying to understand why sometimes the test passes and sometimes not. The questions you need to ask yourself when you write a Selenium test are:

 + Should I wait before it test the content of this element?
 + How long should I try before I retry?
 + What should I do with freaking <a href="http://docs.seleniumhq.org/exceptions/stale_element_reference.jsp">Stale Element Reference Exceptions</a>?

I'm so upset every time I write Selenium tests or work on Selenium tests written by customers that I finally took some time to write my own layer on top of Selenium and <a href="http://phantomjs.org/">PhantomJS</a>. The prototype is called <a href="https://github.com/dgageot/simplelenium">Simplelenium</a>. With Simplelenium, you should be able to write robusts tests without all theses questions.

There's a <strong>lot</strong> missing in this library but I've used it in production and my tests are <strong>much</strong> more stable. Tell me what you think about it.
