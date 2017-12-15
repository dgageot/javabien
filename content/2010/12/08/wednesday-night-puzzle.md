---
title: "Wednesday night puzzle"
date: 2010-12-08T12:00:00+01:00
tags: ["java","puzzle"]
---

What's the result of running this piece of code?

a) Done.
b) InterruptedException is thrown
c) It depends
d) Code doesn't compile

```java
import java.util.Vector;

public class Main {
  interface A {
  }

  static class AImpl implements A {
    static AImpl DUMMY = new BImpl();
  }

  interface B extends A {
  }

  static class BImpl extends AImpl implements B {
  }

  public static void main(String[] args) throws InterruptedException {
    final Vector<Object> values = new Vector<Object>();

    Thread thread = new Thread() {
      @Override
      public void run() {
        values.add(AImpl.DUMMY);
      }
    };
    thread.start();
    values.add(new BImpl());
    thread.join();

    System.out.println("Done.");
  }
}
```
