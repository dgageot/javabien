---
title: "MasterMind Kata in Ioke"
date: 2009-04-28T12:00:00+01:00
tags: ["coding dojo","ioke","kata"]
---

<a href="http://ioke.org/">Ioke</a> is a new language that I've been wanting to learn for a few weeks. I like the vision statement for this language: "<em>Make it as expressive as possible. Period</em>". <a href="http://ola-bini.blogspot.com/">Ola Bini</a>, its author, doesn't want to focus on performances early because it would break expressiveness. Take a look a primitives types versus plain Objects in Java to understand why.

However I had no idea of what interesting code to use it on. Difficult to learn a programming language when you don't know what to program.

So, as I try to go to the <a href="http://xp-france.net/cgi-bin/wiki.pl?DojoDeveloppement">Coding Dojo every Monday</a>, I felt that Ioke could be used to prepare the <a href="http://etienne.charignon.free.fr/spip/spip.php?article79">MasterMind Kata</a> (link in French).

Here is the code, reworked after the Dojo to make it clearer:

```ruby
countCorrectColorAndPosition = method(secret, guess,
  secret zip(guess) count(equals?)
)

countCorrectColorWrongPosition = method(secret, guess,
  pairsWithWrongPosition = secret zip(guess) filter(different?)

  secret distinct map(color,
    countWrongPositionForOneColor(pairsWithWrongPosition, color)) sum
)

countWrongPositionForOneColor = method(pairsWithWrongPosition, color,
  [pairsWithWrongPosition count(first == color),
    pairsWithWrongPosition count(second == color)] min
)
```

```ruby
Mixins Enumerable sum = method(self inject(+))
Mixins Enumerable distinct = method(set(*self))
Mixins Enumerable equals? = method(self inject(==))
Mixins Enumerable different? = method(self inject(!=))
```

```ruby
use("ispec")

describe("countCorrectColorAndPosition",
  it("should recognize when no peg is correct position or color",
    countCorrectColorAndPosition(["B","B","B","B"],
        ["N","N","N","N"]) should == 0
  )
  it("should recognize when one peg is correct position and color",
    countCorrectColorAndPosition(["B","B","B","B"],
        ["B","N","N","N"]) should == 1
  )
  it("should recognize when all pegs are correct positions and colors",
    countCorrectColorAndPosition(["B","B","B","B"],
        ["B","B","B","B"]) should == 4
  )
)

describe("countCorrectColorWrongPosition",
  it("should recognize when no peg is correct color",
    countCorrectColorWrongPosition(["B","B","B","B"],
        ["N","N","N","N"]) should == 0
  )
  it("should recognize when a peg is correct color and wrong position",
    countCorrectColorWrongPosition(["V","B","B","B"],
        ["N","V","N","N"]) should == 1
  )
  it("should recognize when there are more pegs of a given color in the guess than in the secret, and ignore these pegs",
    countCorrectColorWrongPosition(["V","B","B","B"],
        ["N","V","V","N"]) should == 1
  )
  it("should ignore pegs with correct position and color",
    countCorrectColorWrongPosition(["V","B","B","V"],
        ["V","V","N","N"]) should == 1
  )
  it("should recognize when pegs are correct colors for multiple colors",
    countCorrectColorWrongPosition(["V","R","B","B"],
        ["R","V","N","N"]) should == 2
  )
)
```

First part is the code itself.
Second part, I had to write a few Mixins that could be included in standard Ioke library (remember it's a very young language)
Last part are the unit tests, BDD style. I'm more used to TDD so forgive me if it's not <em>pure</em> BDD.

Hope this will make you either want to practice Ioke or come to the Dojo.
