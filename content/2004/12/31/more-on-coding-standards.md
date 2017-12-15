---
title: "More on coding standards"
date: 2004-12-31T12:00:00+01:00
tags: ["coding standards"]
---

After I wrote a teaser on [coding standard]({{< relref "2004/12/30/coding-standards.md" >}}), I found this <a href="http://www.jroller.com/page/matsh/20041018#style_is_symmetry_and_structure">article</a> saying that <strong>Style is symmetry and structure!</strong> I've allways felt that <a href="http://java.sun.com/docs/codeconv/html/CodeConventions.doc6.html#449">Sun's standard</a> was hurting my poor brain but I couldn't say why. Now, thanks to this article, I know why. <strong>Symmetry !</strong>

When one has to impose coding standards, good reasons are mandatory. Rules need to be set in purpose. A proper rule can improve readability and code sharing, or ease debugging, or leave less room to bugs.

Symmetry is the number one rule to improve readability. You can also add whitespaces to your code because they help your brain to understand the structure the code.

```java
result=((methodCall()*2)+(1-methodCall());
```

is less structured than :
```java
result = ((methodCall()*2) + (1-methodCall()) ;
```

Of course a modern IDE will had color to this.
```java
<b><span style="color:#7F0055;">boolean</span></b> result = ((<span style="color:#7F0055;">methodCall</span>()*2) + (1-<span style="color:#7F0055;">methodCall</span>()) ;
```


To ease debugging, a very simple rule taught to every beginner : don't put two statements on the same line :
```java
argv++; argc--;
```

When stepping into code, you really want to know which part of the line you are debugging.

It's been some times that I write <b>if</b> test like this :
```java
if (3.14 == Pi) {...}
```

instead of :
```java
if (Pi == 3.14) {...}
```

to avoid :
```java
if (Pi = 3.14) {...}
```

which is always true (in C/C++). With a modern IDE, it is however not very useful anymore since the IDE can detect things like those.

I like to give prefixes to parameters :
```java
<b><span style="color:#7F0055;">public class</span></b> Test()
{
	<b><span style="color:#7F0055;">private final int</span></b> info ;

	<b><span style="color:#7F0055;">public</span></b> Test (<b><span style="color:#7F0055;">final int</span></b> anInfo)
	{
		info = anInfo ;
	}
}
```

It is also a good idea to make the parameter <strong>final</strong> to avoid changing the value of the parameter instead of the class variable.
