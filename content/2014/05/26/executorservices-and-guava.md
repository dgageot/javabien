---
title: "ExecutorServices and Guava"
date: 2014-05-26T12:00:00+01:00
tags: ["guava","java 8","threads"]
---

If you've written any kind of multi-threaded code with Java, you must know <a href="http://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Executors.html">java.util.concurrent.Executors</a> and <a href="http://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ExecutorService.html">java.util.concurrent.ExecutorService</a> classes. An <code>ExecutorService</code> is an abstraction around threads that can be used to schedule and track the progress of asynchronous tasks. A nice thing about it is that you can write code that uses an <code>ExecutorService</code> and decide later which implementation you choose.

 + <code>Executors.newFixedThreadPool(N)</code> creates an <code>ExecutorService</code> with a fixed <code>N</code> number of threads to run the tasks.
 + <code>Executors.newSingleThreadExecutor()</code> will use a single thread to run the tasks.
 + <code>Executors.newCachedThreadPool()</code> will reuse threads instead of creating a new one for each task. This is useful when you execute lots of short-lived tasks.

Java 8 adds new methods to <code>Executors</code>. One is <code>Executors.newWorkStealingPool()</code>. It creates a pool of "work-stealing" threads with a number of threads equals to the number of available processors on the machine. Useful for async tasks that spawn sub-tasks.

<a href="https://code.google.com/p/guava-libraries/">Guava</a> also provides nice implementations or decorations of <code>ExecutorService</code>. You create them with <a href="http://docs.guava-libraries.googlecode.com/git/javadoc/com/google/common/util/concurrent/MoreExecutors.html">MoreExecutors</a> static factory class.

Let's take a look at two methods that I like:

 + <code>MoreExecutors.getExitingExecutorService(ThreadPoolExecutor)</code> converts a given <code>ThreadPoolExecutor</code> to an <code>ExecutorService</code> that exits when the application is complete. It will tweak the <code>ThreadPoolExecutor</code> to make it produce daemon threads. And it will register a ShutdownHook to wait for their completion. That's something you don't want to write yourself even if it's not complicated. It's useful if you want your application to end gracefully even if some <code>ExecutorService</code> was created somewhere.
 + <code>MoreExecutors.sameThreadExecutor()</code> is a really nice trick to make some multi-thread code run synchronously. What it does it use the main thread, on which the tasks are scheduled, to run the tasks. A very effective way of testing multi-threaded code is to make it synchronous, <code>MoreExecutors.sameThreadExecutor()</code> is your friend!
