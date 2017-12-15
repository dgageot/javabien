---
title: "Git bisect might save your day"
date: 2010-03-23T12:00:00+01:00
tags: ["git","maven"]
---

<strong>The day maven ruined my day (again...)</strong>

Yesterday, I lost 2 hours because our Maven project at <a href="https://beta.algodeal.com/home.html">Algodeal</a> wouldn't build anymore. I couldn't execute:

```bash
mvn eclipse:eclipse
```

nor run the full build.

With the help of a colleague, we found out that only a two steps build would do the trick:

```bash
mvn clean install -DskipTests;mvn eclipse:eclipse
```

Obviously maven is already [not my best friend]({{< relref "2009/05/03/maven2-detractors-are-right.md" >}}) but yesterday I was just fed up.

<strong>How git is called to the rescue</strong>

Luckily I've got one true friend: <a href="http://git-scm.com/">Git</a> and it's little brother <a href="http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html">git bisect</a>.

The question I asked git:

*What did we do that broke the build?*

The answer git bisect gave:

*How stupid you are, you added a plugin in your pom.xml
to enforce the version of maven being used.
Looks like since you've done that,
generating eclipse projects with maven is not possible anymore.*

<strong>Let me replay that in slow motion. </strong>

Git bisect is a handy tool that let's you find a broken commit by bisecting between a well known <em>good</em> commit and a well known <em>bad</em> commit. Instead of trying all the N commits backward from bad to good, you only need to test log(N) revisions being nearer and nearer of the first broken commit.

<strong>Let's apply this to our broken build</strong>

My well known bad commit is current version. Git calls it HEAD.
A well known good commit is version 1.1.3 we released two weeks ago. I can remember that for our latest public release, everything worked ok.

To prove it:

```bash
git reset --hard VERSION1.1.3
mvn eclipse:eclipse
Works ok!
```

So I can start git bisect with this command:

```bash
git bisect start HEAD VERSION1.1.3
```

No all I need to do is run maven and tell git if the build id broken or not using <em>git bisect good</em> or <em>git bisect bad</em>. This will help git find out in which direction to search for the broken build.

Handy isn't it? Instead of testing 282 revisions, I could do it in about 8 steps, git told me.

<strong>Here comes the laziest part</strong>

But you known what? I'm super lazy and would like git to run these 8 steps himself.

Yes we can! says git.

Use `git run <script>` and git bisect will run fully automatically and tell you after a few seconds which revision broke your build!

```bash
cat ../maveneclipse.sh
#!/bin/sh
mvn eclipse:eclipse > /dev/null

git bisect start HEAD VERSION1.1.3
git bisect run ../maveneclipse.sh

running ../maveneclipse.sh
Bisecting: 140 revisions left to test after this (roughly 7 steps)
[49be0b426f3469b154d66179ecdbaad2128b872e] Now formats Javadocs
running ../maveneclipse.sh
Bisecting: 70 revisions left to test after this (roughly 6 steps)
[18a0eddab7a745c9cec538b9184efb25499e06c1] More optimisations
running ../maveneclipse.sh
Bisecting: 37 revisions left to test after this (roughly 5 steps)
[051bccc6252b23be6c9074545986cd057bcc69d8] Merge branch 'master'
running ../maveneclipse.sh
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[1183351cf1976571138c80dcf70e702dc3575177] Merge branch 'master'
running ../maveneclipse.sh
Bisecting: 7 revisions left to test after this (roughly 3 steps)
[a586dcbddca57d93e00ed7ebaeb02239bfdc515c] Merge branch 'master'
running ../maveneclipse.sh
Bisecting: 3 revisions left to test after this (roughly 2 steps)
[b4938d0a2aacabb4e71c2c08cab5e63ce12efbce] Merge branch 'master'
running ../maveneclipse.sh
Bisecting: 1 revision left to test after this (roughly 1 step)
[6536952979f24786db146217b81f7d612bede425] Before we fix the build
running ../maveneclipse.sh
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[56750bb15630dbf1af1976ad0e7161c7ed696e69] Force Maven3
running ../maveneclipse.sh
56750bb15630dbf1af1976ad0e7161c7ed696e69 is the first bad commit
commit 56750bb15630dbf1af1976ad0e7161c7ed696e69
Author: David Gageot <gageot@algodeal.com>
Date:   Wed Mar 17 18:20:29 2010 +0100
    Enforce Maven3
```

Remember that, this could save your day (at least your build).

By the way, I'll be giving talks about git at <a href="http://www.parisjug.org/xwiki/bin/view/Meeting/20100511">Paris JUG</a> in may, <a href="http://www.universite-du-si.com/git-la-gestion-de-configuration-qui-vous-veut-du-bien/4290/">USI2010</a> in july and at <a href="http://chtijug.org/">ChtiJug</a> in april if they find a sponsor. You<a href="http://chtijug.org/devenez-sponsor/"> want to be a sponsor</a> right?
