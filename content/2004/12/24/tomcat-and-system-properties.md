---
title: "Tomcat and System properties"
date: 2004-12-24T12:00:00+01:00
tags: ["tomcat"]
---

Let's say you distribute a web application with<a href="http://jakarta.apache.org/tomcat/index.html"> jakarta-tomcat</a>. Ever wonder how to let your customers change the TCP port tomcat is running on without having them open <em>jakarta-tomcat/conf/server.xml</em> and mess around with XML? <a href="http://www.jroller.com/page/funkman/20041215#let_properties_do_the_talking">Funkman's Weblog</a> gives us a solution. Use System properties to configure dynamically this port (as well as other ports) from the command line with the <em>-D</em> switch. You could also use <a href="http://ant.apache.org/">ant</a> to read a plain text <em>.properties</em> file customers are used to and pass the parameters on the tomcat's command line.

What isn't said in the weblog is that it doesn't seem to work with tomcat 4.0. Sad...
