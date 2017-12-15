---
title: "CoffeeScript: Fun with Comprehensions and Splats"
date: 2014-06-17T12:00:00+01:00
tags: ["coffeescript"]
---

I love <a href="http://coffeescript.org/">CoffeeScript</a>. Some think it's an ersatz to pure Javascript. I think it make writing nice code easier. Here are two concepts that helped me today.

<blockquote>
  Comprehensions
</blockquote>

Comprehensions, is the way CoffeeScript makes for loops very expressive. For example, the following piece of code takes a <code>persons</code> array, filters it and maps it to its <code>name</code> attribute.

```coffeescript
womens = (person.name for person in persons when person.gender is 'F')
```

<blockquote>
  Splats
</blockquote>

With Splats I can pass an array as argument to a function that normally takes multiple arguments. For examle <code>Math.max()</code>. Here's a code sample:

```coffeescript
max = Math.max [1,2,3,4,5,6]...
```

<blockquote>
  Combine both features
</blockquote>

Got an array of persons? Need to compute the max age? Write this:

```coffeescript
maxAge = Math.max (person.age for person in persons)...
```
