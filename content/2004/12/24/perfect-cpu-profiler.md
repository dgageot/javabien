---
title: "Perfect CPU Profiler"
date: 2004-12-24T12:00:00+01:00
tags: ["profiling"]
---

Made some tests of <a href="http://www.yourkit.com/">YouKit</a> Java profiler today. You can make it work with eclipse. When I discovered that I couldn't get interesting results from it without reading the documentation, I started wondering what The Perfect CPU Profiler would do for me.

 + It needs to seamlessly integrate with eclipse. Just a tick box in the launch properties to activate the profiling.
 + It need to be quick. I'm too lazy to choose between tracing and sampling, I want best of both worlds.
 + The results should be presented directly into eclipse. No external interface that I'm not familiar with. I'm here to gain time not to loose some. :-)
 + The profiler should remove the noise out of the captured data and point on the so called <strong>hot spots</strong> at method/line level.
 + I like to see what's going on real time. Offline profiling based on snapshots is like repairing an engine without the noise of it.

Given the time it is and the day it is, it looks like a wish list to Santa Claus... I'll stay with <a href="http://www.borland.com/optimizeit/">OptimizeIt</a> because it's closest to my dreamed profiler.
