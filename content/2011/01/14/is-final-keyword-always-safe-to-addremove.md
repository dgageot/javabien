---
title: "Is 'final' keyword always safe to add/remove?"
date: 2011-01-14T12:00:00+01:00
tags: ["java","puzzle"]
---

If somebody asked me this question "Is it always safe to put/remote 'final' keyword on a read only local variable?", honestly I would have answered "Yes".

Until I read JavaPuzzlers by Joshua Bloch and Neal Gafter and realized what a little variant of puzzle #8 would look like:

What's the output of this code?

```java
public static void main(String[] args)
{
    int z1 = 0;
    final int z2 = 0;

    System.out.println(false ? z1 : 'X');
    System.out.println(false ? z2 : 'X');
}
```
