---
title: "JUnit Max just rocks!"
date: 2009-02-25T12:00:00+01:00
tags: ["eclipse","junit","junit max","tdd"]
---

<a href="http://www.junitmax.com/junitmax/subscribe.html">JUnit Max</a> is an Eclipse plugin developed by <a href="http://en.wikipedia.org/wiki/Kent_Beck">Kent Beck</a> himself. After a few days testing it on a medium size project every day, I can tell you that it just rocks!

The idea being the plugin is very simple and not new: it runs all the unit tests as soon as a source file is saved. The magic is that tests are run in order to give you the quickest feedback possible. To do so, it keeps statistics of most failing/most stable tests and use a few other tricks to run the test that have highest probability to fail first.

The results are there: I closed Junit view for ever in Eclipse and never launch tests manually. More space on the desktop, less clicks. All good!

A few things need to be fixed before it becomes mainstream: Support or multi-module projects in Eclipse, better error trace analysis and display.

If you do TDD and are ready to spend 2$ a month to beta test it, subscribe <a href="http://www.junitmax.com/junitmax/subscribe.html">here</a>. I did and don't regret it.
