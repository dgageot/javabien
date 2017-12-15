---
title: "Yesterday: Gwt happy hours"
date: 2008-06-05T12:00:00+01:00
tags: ["gwt","swing"]
---

Yesterday, <a href="http://www.sfeir.com/">Sfeir</a> organized a GWT evening at "<a href="http://lacantine.org/">La Cantine</a>". It was a nice event with twelve interesting topics.

One topic was a comparison between GWT, Flex and Silverlight. It reminds me the "Swing vs SWT" war a few years ago when I was developing a lot with Swing. The parallel is reinforced by the fact that, for me, coding with GWT is so similar than coding with Swing : I feel the same joy and same disapointment. Same joy writting testable and refactorable code in full Java. Same disapointment dealing with lack of bindings, lack of UI guidelines and too much flexibility.

<strong>Bindings </strong> : This is a force of Flex, WPF and Silverlight over GWT. Declarative bindings is a huge accelerator for simple and repetitive operations. I'm getting used to it with WPF and will miss it next time I develop with GWT.

<strong>Flexibility </strong> : Yesterday, an XP team explained that it took them some time to remember that MVC was a good thing to use in a Swing application and could also be good thing to use in a GWT application. I love Swing and GWT's flexibility but it comes at a price.

<strong>Lack of UI guidelines</strong> : Three years ago, I posted
[an article]({{< relref "2005/11/18/ajax-lookfeel.md" >}})
complaining about most AJAX GUIs being not very usable or at least familiar to users. I still complain. 8 years ago users had troubles with Swing applications because they didn't behave like standard Windows applications. Nowadays, each RIA application has its own look&feel and own behavior which makes it difficult for users and also for developpers who need to reinvent the wheel on each project.

Which of these frameworks will won? I would say none. I'm not even sure that any of these will live as long as Swing or JSPs. It's even funny to see that we are reinventing the wheel again and again, framework after framework : <a href="http://webkit.org/blog/189/announcing-squirrelfish">bytecode interpreter for Javascript</a> (remember JVM ?), Silverlight sandbox (remember Applets?), ...
