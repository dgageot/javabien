---
title: "More tests on Guice"
date: 2008-06-04T12:00:00+01:00
tags: ["guice","spring"]
---

In my previous post, I compared <a href="http://code.google.com/p/google-guice/">Guice</a> and <a href="http://www.springframework.org/javaconfig">Spring JavaConfig</a>. The conclusion is that, for my application, Spring is much easier to use and less verbose. However, the major force of Guice I didn't talk about is it's ability to inject Singletons into large applications in a very (very) effective way.

Let's say you want to inject the same instance of an interface into hundreds of objects:

 + With Spring, you'd declare a bean for each of these hundred objects, so that you can inject the singleton.
 + With Guice, you just annotate the singleton interface with @ImplementedBy(SingletonImpl.class) and annotate each object with @Inject where you need to inject the singleton implementation. Result : not a single line of configuration and it's faster at runtime than Spring.

Next time, I'll check if Spring's @Autowired annotation can do similar things.
