---
title: "Spring JavaConfig"
date: 2008-06-02T12:00:00+01:00
tags: ["guice","java","spring"]
---

Today, I've had the opportunity to test <a href="http://code.google.com/p/google-guice/">Guice</a> on a real project. I must say that the developers really pushed the idea of statically typed IoC very far.

However, trying to port my code from Spring to Guice, I couldn't easily use a properties file for external configuration. Dealing with multiple beans of same type was also not that simple : you either write your own annotations (a bit tedious) or rely on named beans, loosing compile time checks on the way. (For a large project, I would definitly choose the annotations.) Still Guice is quite impressive.

To be fair to Spring, I also gave a try to <a href="http://www.springframework.org/javaconfig">Spring's JavaConfig</a>. So far, I just tested it quickly to explain how it works during Spring training I give. End result : I love it ! You get all Spring benefits over Guice and also get some Guice benefits over Spring : Static typing, properties files, no more XML, refactoring friendly, statically typed named beans, all configuration in one place, no annotations in the code, ... Very impressed !

I'll give a second chance to Guice later on, because I realyze that being a decent Spring user made the transition to Guice more difficult than the transition to JavaConfig.
