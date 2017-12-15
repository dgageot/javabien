---
title: "Avoiding regressions is not difficult"
date: 2008-09-22T12:00:00+01:00
tags: ["tests"]
---

Testing an application is not easy. Automating the tests is even more complex (think about how many tools you need to master compared to just click on the GUI). However the easiest tests to write and automate are regression tests. Those that you write to make sure that bugs will never reappear in your application.

It's easier to write because:

 + You know what to test. The goal of the test is to show a clearly identified buggy behavior. You don't have to guess in advance where your application might fail.
 + You have the application to test. You can imagine that it's more complex to test the application before it's written, even if it' a good practice made possible with modern tools and architectures.
 + The testing tool doesn't have to be clever. The good old action recorder is enough at the beginning.
 + It's easier to find the budget to automate the test. It is part of a "lengthy expensive bug fixing" operation and not of a "develop features as fast as you can" operation. Plus, the customer really hates regressions.

I'm not saying that you should only work on these tests. If you should ever want to write as few as possible tests, these are the easiest to write. It will not result in your application being stable quickly but at least it will be less prone to annoying regressions and will stabilize over time.

Chances are also that once you start writing regression tests, you'll discover the power of automated tests. Think of your system as a black box with known inputs and expected outputs. You compare the real outputs with the expected outputs and you get a test running. Change the inputs and you get a second test running... Capture these data in java test classes, xml files, a fit wiki or scenarios written with a DSL and you have a powerful test engine.

Regression testing is not anymore an objective. It becomes a mean to write better quality code.

So let's all shout "<strong>No regression is good for you</strong>" !
