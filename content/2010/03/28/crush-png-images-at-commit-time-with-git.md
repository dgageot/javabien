---
title: "Crush .png images at commit time with git hooks"
date: 2010-03-28T12:00:00+01:00
tags: ["git","pagespeed","png","web","yslow"]
---

If you are a little involved into writing web applications, you have to know Yahoo!'s <a href="http://developer.yahoo.com/yslow/">YSlow</a> and Google's <a href="http://code.google.com/intl/fr-FR/speed/page-speed/">PageSpeed</a>. These are two Firefox plugins to help you accelerate a web site.

One thing they will help you do is to reduce the size of all those png images to decrease bandwidth. Sure png images are lighter than gifs but still you can remove some fat out of them keeping quality constant. Take a look at <a href="http://developer.yahoo.com/yslow/smushit/">Smush.it</a> if you want to learn more.

There are tools that can do similar things on the desktop. <a href="http://pmt.sourceforge.net/pngcrush/">Pngcrush</a> is one of them. This is as simple as this:

```bash
pngcrush imageIn.png imageOut.png
```

or even better:

```bash
pngcrush -rem allb -brute -reduce imageIn.png imageOut.png
```

Now how can we automate that? If pngcrush was java-based, you could do it dynamically with a servlet filter or at build time using ant/maven. A more effective way to do it, is at commit time using git.

The idea is to crush each png image added to the project the first time it is committed or each time it is updated. Git can do that with a simple hook script that will be executed <strong>pre-commit</strong>.

```bash
#!/bin/sh
# Pre-commit hook that crushes PNG files in order to reduce their size.

if ! which -s pngcrush
then
	echo "Please install pngcrush to reduce png images size before commit"
	exit 1;
fi

for file in `git diff --cached --name-only | grep ".png\$"`
do
	echo "Crushing $file"
	pngcrush -rem allb -brute -reduce $file ${file%.png}.new | grep "filesize"
	mv -f ${file%.png}.new $file
done
```

Have fun!
