---
title: "How I deal with multiple versions of java with Pacifist and Jenv"
date: 2014-05-05T12:00:00+01:00
tags: ["java","jenv","osx","pacifist"]
---

I've been trying to develop with solely Java 8 for more than a year now. However, most of the projects I worked with were still Java 7. Here's how I setup my machine with multiple versions of Java. Be warned that the whole process is not up to my automation standards. There are a lot of manual steps. But I couldn't find a better setup. Maybe you can help me.

<blockquote>
  Install multiple versions of Java
</blockquote>

OSX is well known for installing new versions of Java is some secret, changed every once in a while, place. I don't like that.

I use <a href="http://www.charlessoft.com/">Pacifist</a> to install java where ever I want. I choose <code>~/java/</code> but you can pick whichever folder you want. That's a plus side of the method. The downside is that the process is manual.

Here's the standard procedure: download java, open the <code>.pkg</code> with Pacifist, locate <code>Home</code> folder inside package's hierarchy. Extract the <code>Home</code> folder into <code>~/java/</code>. Uncheck the <code>Use administrator privileges</code>, it's not needed. At last, rename <code>~/java/Home</code> to the name of the jdk. <code>~/java/jdk8u5</code> for example.

It would be great to use a command-line tool to download and unzip the whole thing to the right place. Shouldn't be too hard to do. If someone has time...

<blockquote>
  Configure IntelliJ
</blockquote>

Don't forget to configure this jdk in IntelliJ. I use the same name I used for the folder. Consistency matters.

I'd love to configure IntelliJ just once. Tell it where you put your jdks and let the tool deal with it. Maybe one day...

<blockquote>
  Configure jenv
</blockquote>

I use <a href="https://github.com/gcuisinier/jenv">jenv</a> to switch java depending on the folder I work in. Jenv lets me register each jdk under a different name with <code>jenv add</code> command. I use the same names as the ones I used during the Pacifist step.

Jenv is helpful to register the jdk but it will give a very bad name to it. You have to rename some jenv files manually. A <code>jenv add path name</code> command would be nicer.

What would be even nicer is to configure jenv only once with the folder where I put all my jdks and let it find out which versions are available.

Maybe jenv could also take care of the download like rbenv does for Ruby (if I remember correctly).

<blockquote>
  Conclusion
</blockquote>

Anyway, there's a lot to improve here, but it's nice to type <code>mvn install</code> or <code>java</code> inside a folder and let jenv pick the right version of the jdk.
