---
title: "AssertJ, writing tests just got simpler"
date: 2014-03-24T12:00:00+01:00
tags: ["assertions","assertj","fest assert","tests"]
---

I'm a huge fan of <a href="https://github.com/alexruiz/fest-assert-2.x">FEST-Assert</a>. I've been using the version 1 since 2008 or something. I made people switch to FEST. I presented FEST at the Paris JUG. I used FEST for almost all my
[Brown Bag Lunches]({{< relref "2012/11/05/bbl.md" >}}). And now I don't use it anymore...

<blockquote>
  What?
</blockquote>

Yes, I don't use FEST-Assert anymore. It failed to evolve quickly enough. Like any other Api, an assertions Api needs to evolve.

<blockquote>
  So what do I use?
</blockquote>

I've using <a href="http://joel-costigliola.github.io/assertj/">AssertJ</a> on all my projects for a couple of months. It's a fork of FEST that has proved it could evolve very quickly. It was launched during <a href="http://www.devoxx.fr/">Devoxx France</a>, last year and now it provides a awful lot of nice fluent assertions. Here a sample taken from one of my BBLs:

Here is the FEST-Assert code:


```java
List<Item> items_1 = new ItemsProvider().getItems();
List<Item> items_2 = new ItemsProvider().getItems();

assertThat(items_1).hasSize(items_2.size());

for (int i = 0; i < items_1.size(); i++) {
  Item item_1 = items_1.get(i);
  Item item_2 = items_2.get(i);

  assertThat(item_1.getName()).isEqualTo(item_2.getName());
  assertThat(item_1.getQuality()).isEqualTo(item_2.getQuality());
  assertThat(item_1.getSellIn()).isEqualTo(item_2.getSellIn());
}
```

Here is the AssertJ code:

```java
List<Item> items_1 = new ItemsProvider().getItems();
List<Item> items_2 = new ItemsProvider().getItems();

assertThat(items_1).usingFieldByFieldElementComparator().containsExactlyElementsOf(items_2);
```

Notice how much more compact it is and still easy to read? Also it will break if you add new fields to <code>Item</code> that don't follow the contract. It means you're writing tests that are easier to maintain. That's nice!
