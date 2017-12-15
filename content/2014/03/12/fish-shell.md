---
title: "Fish Shell"
date: 2014-03-12T12:00:00+01:00
tags: ["fish","jug"]
---

Yesterday, <a href="https://twitter.com/sdouche">Sébastien Douche</a> gave a nice talk about virtualisation at the <a href="http://www.parisjug.org/xwiki/bin/view/Meeting/20140311">Paris JUG</a>.

We have lots of common points Sebastien and I. First, we are both 39. Second, we both love Java (Not sure of this one though). Third, he uses <a href="http://fishshell.com/">fish shell</a> and I had a love affair with fish shell from 2008 to 2010.

Fish shell is a really nice replacement to bash or zsh. With lots of valuable feature like Autosuggestions, good tab completions and out of the box color support. I can't remember why I dropped it in 2010. Maybe the lack of evolutions. Or poor git completions. But it looks like it was updated a lot those last years.

So, anyway Sébastien's talk, yesterday, made me want to use fish shell again. So let's do it.

```bash
$ brew install fish.
$ echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
$ chsh -s /usr/local/bin/fish
```

Done. I will tell you if love is back.
