---
title: "We can't write expressive code"
date: 2009-01-12T12:00:00+01:00
tags: ["agile","expressive code","raskin","xp"]
---

Ever since there are programming languages, good programmers have tried to write code that is expressive enough to be understood and maintained. However, put two good programmers face to face and chances are they might agree on what <em>expressive</em> mean but they won't agree on how to do it.

![haskel](/images/haskel.jpg#center)

Some think that <strong>less is better</strong> and prefer to use a language whose syntax is compact, preferably a functional language or similar. Some think that the temptation to write <strong>one-liners</strong> (or <a href="http://www.linux-france.org/prj/jargonf/P/punch.html">punch</a>es in the good o' days of GFA Basic...) being too strong, the code will be compact but not readable.

Some think that <strong>comments</strong> are very important. Like <a href="http://en.wikipedia.org/wiki/Jef_Raskin">Jef Raskin</a> who would write its code embedded into a standard text processor (1). Some think that comments are by nature out of sync with the code, so dangerous, and prefer<strong> unit tests</strong> to express <strong>code behavior</strong>.

Some prefer to write long procedures you can read linearly, some prefer lots of classes and methods, some prefer OO/Aspect/Ioc/(any buzzword) oriented programming, some think this is dangerous <strong>dark magic</strong> that changes the code in your back.

Some think that code structure should be treated like GUIs structure, following the same rules to make it quickly <em>usable</em> by new developers. Some think that this is a lost crusade since programming languages tend to not follow Jef Raskin's <a href="http://www.amazon.fr/gp/product/0201379376?ie=UTF8&tag=jabi-21&linkCode=as2&camp=1642&creative=6746&creativeASIN=0201379376">Monotony of design rule</a><img src="http://www.assoc-amazon.fr/e/ir?t=jabi-21&l=as2&o=8&a=0201379376" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />: there should be only one way to accomplish a certain task in an application.

I think that it's impossible to write code that is understandable by every developer, even if you focus only on good developers. Every communication between human beings is ambiguous by nature.

We understood this some times ago about written specifications but not yet for written code. Understanding a piece of code is so linked to the context it is presented to you, to your knowledge of the programming language, to your level of expertise in this language...

<blockquote>One advice that XP teams teach us: agree on coding standards within your team. This is complex enough to not even try to convince people outside the team.</blockquote>

(1) <a href="http://www.amazon.fr/gp/product/1556152116?ie=UTF8&tag=jabi-21&linkCode=as2&camp=1642&creative=6746&creativeASIN=1556152116">Programmers at Work: Interviews With 19 Programmers Who Shaped the Computer Industry</a><img src="http://www.assoc-amazon.fr/e/ir?t=jabi-21&l=as2&o=8&a=1556152116" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
