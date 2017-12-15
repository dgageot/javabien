---
title: "I don't like inheritance in Java and now I know how to explain why"
date: 2009-06-19T12:00:00+01:00
tags: ["clean code","java"]
---

I tend to dislike very <em>very</em> much class inheritance in Java. However, until today, it was not easy to explain why.

I've always said that beginners do a lot of duplication when they code, medium programmers solve this problem using class inheritance, good programmers find every possible way to abstract even more and get rid of class inheritance, sometimes even for the price of a small duplication (due mainly to java limitations).

If you search keyword <em>extends</em> in your code base, how many times doest it appear compared to keyword <em>class</em>?

![Dead Donkey](/images/floral_matryoshka_set_11-300x225.jpg#center)

[Update]<a href="http://www.javaworld.com/javaworld/jw-08-2003/jw-0801-toolbox.html">There are plenty of reasons to not abuse of class inheritance</a>. Most good developers know them. Still it takes some time and some maturity to understand. I found that a simple way to demonstrate the bad effects of class inheritance is to focus on code readability.[Update]

<strong>If you don't agree, let me ask you to play a little game: open Spring framework sources on any complex class, eg. CancellableFormController and try to follow the code. Once you're lost you should agree at least a bit.</strong>

Although Spring source code is very well documented, and pretty well written, I very often fail to understand the big picture. It's the archetype of code using way too much class inheritance. Sometimes up to five or ten levels of inheritance (8 levels for CancellableFormController). It's impossible to read: too difficult to understand which method is really executed or replaced by another. And the tools don't help since most of those IDEs I know of cannot show a merged view of a class hierarchy. You jump from one class to another for each method.

What do you think?
