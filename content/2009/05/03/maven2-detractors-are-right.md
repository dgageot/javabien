---
title: "Maven2 detractors are right"
date: 2009-05-03T12:00:00+01:00
tags: ["maven"]
---

There is a crisis going on within the Maven community. Some think that Maven has become something too complicated, too difficult to maintain and evolve. I say it loud (even if few people care): <strong>I fully support these detractors.</strong>

Being a Maven2 users on a daily basis, I've been looking for a replacement for a long time. I tried Buildr (wasn't convinced). I'll give a try to Gradle soon. The reason? Maven is the kind of tool that solves a lots of problems but invents new ones. At the end of the day, I'm not sure it helps my team to be more productive.

Why? Maven relies on two lies:

 + First lie: Transitive dependencies.
 + Second lie: Universality.

<strong>Transitive dependencies</strong>
This will never work. Bad poms, library conflicts, runtime dependencies... At the end of the day, it's better to explicitly declare all dependencies. Relying on implicit dependencies is a short term gain. A build system is here to stay so it shouldn't rely on short term gains.

<strong>Universality</strong>
You can build with maven, and run tests, and integration tests and deploy, and generate reports, and, and... Stop, stop, this is already too much. Yes the plugin system is a nice to have but it tends to make users think everything can be done within Maven. Me included thought that I should put as much as possible in my pom.xml when a simple ant file could replace in a very reliable manner a bunch of buggy plugins. Maven should do one and only one thing right: build jars from sources.

<strong>Complexity is ok, lies are not</strong>
For most people, it's hard to accept that a system too powerful is dangerous for the users. I think a system can be powerful. It can even be complex but it shouldn't make users believe in lies. Same thing for Spring. It's powerful. It's complex. I like it.
[But it makes people think that JavaBeans is a good design]({{< relref "2008/12/30/springs-flaws.md" >}}).
