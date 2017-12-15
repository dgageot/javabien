---
title: "Groovy or not Groovy?"
date: 2004-12-27T12:00:00+01:00
tags: ["groovy"]
---

Looks like things are getting <a href="http://www.jroller.com/page/fate/20041210#the_groovy_sinking_ship">hot</a> for <a href="http://groovy.codehaus.org/">Groovy</a>.

As you might know, Groovy is the latest scripting language on steroids. It contains some nice features such as Closure support, Groovy Markup, Native syntax for Lists and Maps, Regex, ... all of these on top of a JVM meaning a great support of Java APIs. Unfortunately for Groovy, the JVM supports plenty of <a href="http://www.robert-tolksdorf.de/vmlanguages.html#scripting">script engines</a>. To be considered a first class citizen, Groovy has at least to be stable and well supported by its community.

 + Given the grammar and parser that it currently uses, it cannot be called <a href="http://jroller.com/page/pyrasun/20040328#groovy_ambiguities_optional_elements_and">very stable</a>.
 + However, support seems to be <a href="http://www.jroller.com/comments/fate/?anchor=the_groovy_sinking_ship#comment20">there</a> with a little lack of communication.

Future is brighter!

For now, I'll use <a href="http://www.beanshell.org/">BeanShell</a>, my favorite scripting language. Why?

 + It cannot be simpler to learn. It uses JAVA 5 syntax.
 + I don't have to declare type of variables and parameters. It's the minimum we ask for a fast prototyping language.
 + Easily embedded into existing JAVA apps.
 + I can do things forbidden in proper JAVA, such as have access to private fields.
 + It supports JavaDoc for the scripts.
 + It is stable.
