---
title: "False warnings in IDEA Intellij, what a pain!"
date: 2010-12-07T12:00:00+01:00
tags: ["intellij"]
---

I'm a big fan of Eclipse, I've been using Visual Age and the very first version of Eclipse. It's far from perfect but I've come to know its weaknesses and became quite efficient.

Every once in a while I take some time to evaluate Intellij IDEA, because, you know, its SOOOOO much better than Eclipse. Not using it only proves you are both stupid and tasteless. That's what one can hear. I'd love to love this tool but each time I start using it, it looks like he doesn't like me.

Here is the latest bug I've spotted while playing with the otherwise nice code inspection feature.

Let's say you've got this piece of code:

```java
class BugInteger {
    Integer sum(Integer numberOfLongTrades, Integer numberOfShortTrades) {
        return null == numberOfLongTrades ? numberOfShortTrades :
               null == numberOfShortTrades ? numberOfLongTrades :
               (Integer) (numberOfLongTrades + numberOfShortTrades);
    }

    public static void main(String args[]) {
        System.out.println(new BugInteger().sum(1, 2));         // prints 3
        System.out.println(new BugInteger().sum(null, 2));      // prints 2
        System.out.println(new BugInteger().sum(1, null));      // prints 1
        System.out.println(new BugInteger().sum(null, null));   // prints null
    }
}
```

IDEA warn me on this code, saying the <b>(Integer)</b> cast is redundant. Looks like it is indeed, so I click on the light bulb to remove the faulty cast. Guess what, my unit tests fails with a NullPointerException.

Looks like the cast was not so redundant! In fact it's here to protect me from unboxing a null Integer.

This is the typical false warning you'll get often with IDEA. The kind that makes you disable all the inspections because they are so unreliable. <b>A warning should be an advice you can follow or not, but it should NEVER break the code</b>.

If you think this an isolated bug, then let's say I've seen dozens isolated bugs each time I test IDEA. For now, I'll keep on testing seriously and will try to post some more positive/negative insights.
