---
title: "Maven timeline plugin"
date: 2014-04-22T12:00:00+01:00
tags: ["build","maven"]
---

I often work with my customers on shortening the build process. Very often it's a Maven build.

An easy way of making a multi-modules build shorter is to use Maven's parallel build feature with something like <code>mvn -T2 clean install</code>

However, that's not always as effective as one could think. Because of dependencies between modules, not all modules can be build in parallel. In fact, if you could look at how many modules are really run in parallel, you'd be surprised it's only a few. All your nice CPU cores mostly spend their time doing nothing.

Because it's not easy to guess which modules are waited by which, I wrote a small maven extension that plugs into the build lifecycle and measures the time taken by each phase. The results are then output to a <code>target/timeline.html</code> file for easier visualisation.

Here's what the html file looks like:

![Timeline](/images/Screen-Shot-2014-04-22-at-11.02.34.png#center)

Here's the <a href="https://github.com/dgageot/maven-timeline">maven-timeline plugin</a>. (It should be synched with maven central later today)

Feel free to fix bugs and do whatever you want with this plugin.
