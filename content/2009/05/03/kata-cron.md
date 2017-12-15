---
title: "Kata cron"
date: 2009-05-03T12:00:00+01:00
tags: ["coding dojo","cron","ioke"]
---

I'm currently in search for new ideas of programming katas for the <a href="http://xp-france.net/cgi-bin/wiki.pl?DojoDeveloppement">coding dojo</a>.

A small feature really impressed me in Google App Engine: the <a href="http://code.google.com/intl/fr-FR/appengine/docs/java/config/cron.html#The_Schedule_Format">new cron feature uses plain english</a> to define the frequency of cron jobs. Have you ever add to decode <a href="http://www.adminschoice.com/docs/crontab.htm#Crontab%20file">standard crontab syntax</a>?

```
"0 0 12 * * ?" means "Fire at 12pm (noon) every day".
"0 15 10 ? * 6L" means "Fire at 10:15am on the last Friday of every month"
```

Which syntax do you prefer?

So here are two dojo ideas that I will try to develop using Ioke:

 + Easiest: translate "* * * * *" syntax to plain english
 + Harder: translate plain english to cron syntax
