---
title: "Spring's flaws"
date: 2008-12-30T12:00:00+01:00
tags: ["spring"]
---

I love <a href="http://www.springsource.org/">Spring Framework</a>. I use it on almost every project and I'm pretty close to think that I couldn't leave without it. However, lots of people really dislike it for plenty of reasons. This makes me wonder what are the real flaws I would name.

<strong>The first flaw that comes to my mind is the documentation.</strong>

Really? When giving <a href="http://www.valtech-training.fr/fr/index/training/formations/Frameworks_Java_EE/SPRI.html">training on Spring for Valtech</a>, I'd always tell trainees that the <a href="http://static.springframework.org/spring/docs/2.5.x/reference/index.html">documentation</a> was very well done. In fact it is. But, it is pretty outdated. Not for its content but <strong>for the way it considers xml as the primary configuration paradigm all the way through</strong> (well, not for aspects).

Xml DSLs are verbose, lack serious static checking and, let's be honest, XML wasn't really made to do this kind of things.

Spring has been able to use other configuration paradigms (none, plain java, annotations, JavaConfig...) for a long time but this is very often considered secondary options.

Maybe Spring 3 will change this by sort of "deprecating" xml configuration. I'm just afraid that annotations will be the new primary configuration paradigm that we'll complain about in the coming years.

Speaking about documentation, another flaw is the bias towards plain JavaBeans. Spring is really pushing a POJO approach but people understand pure JavaBeans. With default constructor, getters and setters...

This was not Spring's original intent and, believe me it it still very powerful in integrating frameworks not based on JavaBeans (ever tried <a href="http://joram.objectweb.org/">Joram</a>?). But <strong>reading the documentation, the borders between POJO (ie. any Java object that you can write) and JavaBeans (overused silly reflectable properties wrappers) tend to blur.</strong> Why did they use the name <em>Spring beans</em>? I think it was to show the lightweight approach compared to Enterprise Java Beans. But now that EJBs are dead in the form we used to know, people think Spring is pushing a design based on <a href="http://java.sun.com/javase/technologies/desktop/javabeans/docs/spec.html">JavaBeans specification</a>. Change the documentation please!

What do you think? Please no bashing!

<em>Other flaws coming in future articles...</em>
