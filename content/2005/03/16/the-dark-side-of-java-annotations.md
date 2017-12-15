---
title: "The Dark Side of Java Annotations"
date: 2005-03-16T12:00:00+01:00
tags: ["annotations","java"]
---

More and more tools are taking the train to Java Annotations. Most of them to ease code and xml descriptors generation. Look at <a href="http://xdoclet.sourceforge.net/xdoclet/index.html">XDoclet</a>. It was supporting dozens of tools way before the introduction of metadata annotations in Java 5 with <a href="http://www.jcp.org/aboutJava/communityprocess/review/jsr175/">JSR 175</a>.

The main reason why we, developers, like to use these annotations is that they help us concentrate on the Business logic, not on the framework, not on the proxies, implementations, descriptors, pick any... Code becomes clearer, safer and faster to write.

However, we have to be very careful on what we are using these annotations for. We shouldn't express runtime information here. By runtime information, I mean data that one could change to adapt to its runtime environment. Let's take an example : It's ok to say which fields of you classes have to be saved in the database. It's not ok to say which table to use. If we put the table name in the annotations, we'll have to recompile and redeploy the application to change the table names. With standard XML descriptors and a dynamic implementation of our framework, we can change only the xml file.

If the future is to put everything in the code with annotations, maybe we should give the sources to the application server and let it choose between recompile or impact changes in the annotations.
