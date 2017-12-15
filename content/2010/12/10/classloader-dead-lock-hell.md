---
title: "Classloader dead-lock hell"
date: 2010-12-10T12:00:00+01:00
tags: ["classloaders","java"]
---

My previous post presents a typical classloading dead-lock. Java classloaders are lazy by nature and when two different threads need to load two classes with a cyclic dependency (A references B, B references A), there is a good chance that the two threads end up being blocked one by the other.

Here is the simplest code I found to show the problem:

```java
public class Main {
    static class A {
        static B B = new B();
    }

    static class B extends A {
        void hello() {
            System.out.println("Hello");
        }
    }

    public static void main(String[] args) throws InterruptedException {
        Thread thread = new Thread() {
            @Override
            public void run() {
                A.B.hello();
            }
        };
        thread.start();
        new B().hello();
        thread.join();
    }
}
```

You should be able to reproduce the problem. But sometimes, if one thread is for any reason slower than the other one, it will work ok.

I wonder if tools like Sonar, FindBugs or PMD can spot this kind of problem with static code analysis. It seems very easy to do. Any feedback on these tools?
