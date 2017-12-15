---
title: "Technical retrospective after 2 years at Algodeal"
date: 2010-07-16T12:00:00+01:00
tags: ["git","infinitest","junit max","mockito","serverless ci","tdd"]
---

For two years I've been working at <a href="https://beta.algodeal.com/home.html">Algodeal</a>. Two great years full of fun and challenges, going back to full-time developer after 4 years of technical consulting and agile coaching. Being the CTO at <a href="https://beta.algodeal.com/home.html">Algodeal</a>, I thought that hiring a small team of talented people and being an equal part of this development team would be fun. It is! It worked for me at <a href="http://fr.adesoft.com/">Adesoft</a>. It worked again.

If I had to do a technical retrospective, here's what I'd say:

<strong>There are great tools for java developers out there. Want to know my top 4?</strong>

<strong><a href="http://git-scm.com/">Git</a></strong>: I've said it millions of times this year: you have to learn git. No excuse. Using a different VCS would really hurt now. Using git everyday for 2 years was also a good reason to make a <a href="http://www.slideshare.net/dgageot/tag/git">lot of presentations</a> to various companies, users groups and conferences. (Even more to come later the year) If you need to be any more convinced, go check out how [git bisect could save your day]({{< relref "2010/03/23/git-bisect-might-save-your-day.md" >}}).

<strong><a href="http://mockito.org/">Mockito</a></strong>: The other tool dear to my heart. Other mock framemorks made it clear that I should stay away from mocks and stubs, except for custom-made ones. Now, this all changed. I'm pretty sure that this kind of tool can make your tests quite redeable and super easy to refactor. A mindset change is all it takes. I got rid of most custom stubs, fakes and builders I used to write. <a href="http://www.slideshare.net/dgageot/mockito-chti-jug">Slides in french</a>.

<strong><a href="http://code.google.com/p/guava-libraries/">Google Collections</a>, aka Google Guava</strong>: Ever wanted to write pseudo functional code in Java? This is easy with Functions and Predicates and a little bit of glue in between:

```java
List<String> months = Arrays.asList(
    "January", "February", "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December");

String juneToJuly = with(months).only(startsWith("J")).exclude("January")
    .to(UPPERCASE).join(" to ");

assertThat(juneToJuly).isEqualTo("JUNE to JULY");
```

Nice isn't it? Guava is full of other surprises, <a href="http://guava-libraries.googlecode.com/svn/trunk/javadoc/com/google/common/base/Suppliers.html">Suppliers</a>, <a href="http://guava-libraries.googlecode.com/svn/trunk/javadoc/com/google/common/util/concurrent/Futures.html">Futures</a>, <a href="http://guava-libraries.googlecode.com/svn/trunk/javadoc/com/google/common/base/Preconditions.html">Preconditions</a>, to make code faster and more reliable.

<strong><a href="http://improvingworks.com/products/infinitest/">Infinitest</a></strong>: At first, there was <a href="http://www.junitmax.com/">JUnitMax</a>, written by Kent Beck himself. An eclipse plugin that would run the full test suite for every change you make in the code base. It really changed the way I TDD. I loved this tool, I talked about it to everybody, until Kent Beck decided to discontinue the tool (guess what, one year after, he changed his mind). Enters <a href="http://improvingworks.com/products/infinitest/">Infinitest</a>: better, faster, stronger. If you do TDD and don't use a continous testing tool, you really miss something fundamental. Tools are mature enough for you to get onboard.

<strong>Team of 5 or 6 is perfect size:</strong>

It's incredible how fast a small team can go. I've been in bigger teams and it's so hard to keep everybody informed, and up to date. It's so hard that you don't do it. A team of 5 is made of enough opposite points of view and yet is quite easy to focus as a one. Sure a few expertise remain not shared by everyone, but with a team this size, everybody knows what he doesn't know. And when it becomes depressing, he learns. In a large team, you don't even know what you don't know.

<strong>Build and test the whole thing fast. I mean fast:</strong>

This one I'm very proud of. From the beginning, we took good care of our test suite and tried to keep it as fast as possible. By fast, I mean under 4 minutes for the full build, unit tests, integration tests and functional tests. Guess what is the biggest benefit you get for free, trying to keep a quick build? You gain to challenge any business and technical decision: Will it be easy and quick to test? Will the tests be stable (anybody testing ajax)? If the answer is NO, then is the feature really useful for the users? Can it be done a simpler way. Turns out that if it can be easily/quickly tested, it can be easily/quickly developped, easily/quickly deployed and easily/quickly used.
Not always true of course, but often enough for this to become one of our hard rules.

It even lets us do [unbreakable serverless continous integration]({{< relref "2009/12/01/serverless-ci-with-git.md" >}}).
Wanna try?

<strong>Challenging the architecture often is a good habit:</strong>

It forces you to choose an architecture easy to deploy and easy to get rid of. Eg. We got rid of <a href="http://project-voldemort.com/">Voldemort</a> in one day. That was super easy since it's API is made of thow methods get(key), put(key, value). Compare that to JDBC API. If you want the full story, the data that we now store on <a href="http://hadoop.apache.org/">HDFS</a>, was first stored on a local filesystem, then on a remote filesystem, then on Voldemort.
An architecture that you cannot refactor or get rid of easily might not be worth setting up in the first place.

Hope this retrospective will help you and your team. Any feedback is welcomed.
