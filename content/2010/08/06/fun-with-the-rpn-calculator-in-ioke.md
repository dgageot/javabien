---
title: "Fun with the RPN calculator in Ioke"
date: 2010-08-06T12:00:00+01:00
tags: ["fantom","haskell","ioke"]
---

In <a href="http://beust.com/weblog/2010/08/04/fantom-and-haskell/">this article</a>, Cédric Beust explains how to port a RPN calculator from Haskell to Fantom. It could have made me want to code more in Haskell or go discover Fantom. Not at all. Reading the article, I felt the urge to code the same algorithm with <a href="http://ioke.org/">Ioke</a>. You know, this language I discovered through a [MasterMind Kata]({{< relref "2009/04/28/mastermind-kata-in-ioke.md" >}}) a while ago.

Here is the Fantom code:

```ruby
foldingFunction := | Int[] n, Str p -> Int[] | {
  echo("n:" + n)
  switch(p) {
    case "*" : return n.push(n.pop * n.pop)
    case "+" : return n.push(n.pop + n.pop)
    case "-" : return n.push(n.pop - n.pop)
    case "/" : return n.push(n.pop / n.pop)
    default: return n.push(p.toInt)
  }
};
"8 1 2 + 5 * +".split.reduce([,], foldingFunction)
```

Here is my first try with Ioke:

```ruby
rpn=method(sum, x,
  case(x,
    "+", [sum pop! + sum pop!],
    "*", [sum pop! * sum pop!],
    "-", [sum pop! - sum pop!],
    "/", [sum pop! / sum pop!],
    [x toRational]
  ) + sum
)
"8 1 2 + 5 * +" split fold([], sum, x, rpn(sum, x)) println
```

Quite neat. The code looks a lot like the Fantom code or even the <a href="http://learnyouahaskell.com/functionally-solving-problems">Haskell code</a>/
Now let's use the power of Ioke and remove duplication by defining <em>rpn</em> method on <em>List</em> itself :

```ruby
List rpn = method(x,
  append!(case(x,
    "+", pop! + pop!,
    "*", pop! * pop!,
    "-", pop! - pop!,
    "/", pop! / pop!,
    x toRational
    )
  )
)
"8 1 2 + 5 * +" split prepend!([]) fold(rpn) println
```

I like that one better. We could remove some more duplication at the expense of readability, because, you know, there must be another way to convert "+" to , "*" to * and "-" to -:

```ruby
List rpn = method(x,
  append!(case(x,
    or("+","*","-","/"), Message fromText(x) appendArgument(pop!) sendTo(pop!),
    x toRational
  ))
)
```

Here we used reflection, but we could use eval method and regexp:

```ruby
List rpn = method(x,
  append!(if(x !~(#/[-+*/]/),x toRational,Origin eval("#{s pop!}#{x}#{s pop!}))
)
"8 1 2 + 5 * +" split prepend!([]) fold(rpn) println
```

Ok, now let's try to recall those days I was an expert in Perl, and compress this to the max:

```ruby
r=fn(e,e split fold([],s,x,s append!(if(x !~(#/[-+*/]/), x toRational,
Origin eval("#{s pop!}#{x}#{s pop!}")))))
r("8 1 2 + 5 * +") println
```

This one, I'm not really proud of. Should I?
