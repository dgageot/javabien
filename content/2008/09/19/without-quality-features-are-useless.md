---
title: "Without quality, features are useless"
date: 2008-09-19T12:00:00+01:00
tags: []
---

I joined a new company this monday. During this first week, I took some time to evaluate a few tools/technologies I might need to get the job done : grid middleware, virtualization tools, Java IDEs, testing framework, ... I ended up quickly testing a lot of things. A secret wish I had while doing that was that I could find better tools to replace those that I've be using for a long time.

Let's take an example: Eclipse IDE is slowly getting fat and heavy. It's having more and more plugins out of the box. I know I can uninstall things at will thanks to osgi plugins. It takes (eats?) time. I also know I used to appreciate the default package that Eclipse provided a few versions ago. Now my menus are filled with lots of options I don't want, making it more complicated to find the options I do want. It looks like MsOffice without the personalized menus.
There is also the fact that Maven support is bad. Subversion support has never been very stable, etc.

So I decided to give a try to IntelliJ.

It didn't make it.

I could have lived with remembering new keybindings and finding the plugin's that I really want. Unfortunately I cannot live with an IDE that freezes every 10 minutes on a MacPro. I could have spend some time to find the solution. In fact I did. Found nothing. This was the end of my IntelliJ experience. <strong>Without quality, features are useless</strong>.

I must say that IntelliJ was not the only tool that didn't survive my roundups:

 + chroot, a tool to run code in a protected environment on your Linux box is useless because it can be bypassed easily. Why not just throw it away?
 + m2eclipse, a plugin to integrate maven2 in eclipse is very unstable. Maven support in IntelliJ is not better. Go back to command line: it's an additional window but is stable.
 + Same results with git plugins for Eclipse and IntelliJ. Better do the job in Terminal.
 + Same results with TestNG plugin in Eclipse. IntelliJ one looks better. Right now it's really the main reason for me not using TestNG more often. I'll try to live with the plugin which doesn't act as I expect it to do: I get differents red/green results depending on how I launch the tests. Not good...
 + I could go on and on...

All these tools seem to think that providing more features to the users is enough. It is not if you lose quality on the way of increasing release frequency. Also, the more often you release, the more you face compatibility problems between tools. Version 0.9.5RC1 of plugin X will only work well with version 3.2.1 of your IDE. The exact version you don't want because it doesn't play friendly with version 5.6.7.1 of plugin Y... In this world where we release thnig faster and faster, dependency management systems have great days before them. (And no, Debian's apt doesn't solve the problem. Not much more than Maven's transitive dependency system or Eclipse osgi plugins)

So please software makers, please slow down a lot. Build quality in first. And then keep on accelerating if you like. <strong>But build quality in first !</strong>
