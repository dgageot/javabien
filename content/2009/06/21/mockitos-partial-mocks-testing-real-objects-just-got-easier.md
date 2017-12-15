---
title: "Mockito's partial mocks. Testing real objects just got easier"
date: 2009-06-21T12:00:00+01:00
tags: ["java","mockito","mocks","tests"]
---

In [this article]({{< relref "2008/12/17/wanted-syntaxe-pour-remplacer-une-methode-dun-objet-dans-un-test-unitaire.md" >}})
(in french), I wrote 6 months ago, I was searching for a mockito-like syntax to stub only one method of an object instance under test. Mockito brought it in it's <a href="http://mockito.org/">latest version</a>.

![](/images/fakearm.jpg#center)

Here is a recap of the need:

This is what I usually write to mock a method of a real object (usually to return a mock):

```java
CopyFileRule rule = new CopyFileRule("src.txt", "dest.txt") {
	@Override
	protected FileTemplate createFileTemplate() {
		return mock(FileTemplate.class);
	}
};
```

This is clear enough but in real life, it tends to be more complex than in this example. Let's say that CopyFileRule is Serializable, that createFileTemplate takes arguments that you's like to check and that you use mockFileTemplate outside of CopyFileRule. Here is what the code would look like:

```java
<strong>final</strong> FileTemplate mockFileTemplate = mock(FileTemplate.class);

CopyFileRule rule = new CopyFileRule("src.txt", "dest.txt") {
	<strong>static final long serialVersionUID = ...</strong>; // Otherwise Eclipse will complain

	@Override
	protected FileTemplate createFileTemplate(String type) {
		<strong>assertEquals("TYPE1", type);</strong>
		return mockFileTemplate;
	}
};

verify(mockFileTemplate).copy("src.txt", "dest.txt");
```

A little bit more confusing...

This is what I'd like to write:

```java
CopyFileRule rule = intercept(new CopyFileRule("src.txt", "dest.txt"));

FileTemplate mockFileTemplate = mock(FileTemplate.class);
when(rule.createFileTemplate("TYPE1")).thenReturn(mockFileTemplate);

verify(mockFileTemplate).copy("src.txt", "dest.txt");
```

Simpler and keeps the given/when/then flow clear.

<a href="http://mockito.org/">Mockito 1.8-rc1</a> introduces real partial mocks which are exactly that.

You create an object instance calling one of its constructors and you tell Mockito that you are willing to change some methods for this instance :

```java
CopyFileRule rule = spy(new CopyFileRule("src.txt", "dest.txt"));
```

You replace a method:

```java
when(rule.createFileTemplate()).thenReturn(mockFileTemplate);
```

Exactly the syntax I wanted! And it works for public AND protected methods, wether the method is called from the outside or the inside of the spied object.

Who said Mockito didn't rule?

There is only one caveat to this syntax. The real rule.createFileTemplate() method will be called once. This can have a lot of side effects and might even fail throwing an exception (very often a NPE). To solve this, you can (should?) use this alternative Mockito syntax:

```java
doReturn(mockFileTemplate).when(rule).createFileTemplate();
```

I like this syntax for partial mocks because it has no side effect and because it makes a difference between standard mocks and partial mocks.

<strong>A final warning: partial mocks should be used with caution. It's powerful but can lead to poor design.</strong>

<strong>Shameless plug: Prototype based languages can do this natively. It might be the time to try <a href="http://ioke.org/">Ioke</a></strong>
