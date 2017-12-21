---
title: "I migrated my Blog to Hugo"
date: 2017-12-19T18:21:00+01:00
tags: ["hugo","wordpress","firebase","circleci"]
---

For years, this blog has been served by Wordpress. Actually, the [first
post]({{< relref "2004/12/22/prise-en-main-de-wordpress.md" >}}) (in french)
was about starting a Wordpress blog.

> It served me well until it didn't

For almost as many years, I've been wanting to migrate all the posts to some
templating engine that would generate static pages. I thought it would be easier
to write and also easier to host.

I've almost migrated to Jekyll when I wrote one post per day
[early 2014](/2014). What stopped me was not Jekyll but the burden of porting
old html posts written with the Wordpress WYSIWYDon'tG editor.

To partially solve my problems, I installed the Jetpack plugin to blog in
Markdown. That was much better. I also ran Wordpress inside Docker. That was
much easier to operate.

> Let's try again but harder!

Fast-forward to last week. I took a deep breath and migrated all the posts to
plain markdown, fixed the images and cross links, imported the comments to
Disqus, started to learn [Hugo](https://gohugo.io) (the easiest part) and chose
a [minimal theme](https://themes.gohugo.io/minimo/).

Yeah! Migration done!

> Where should I host it now?

I didn't really care where the blog would be hosted. I cared about a few things
though. It should:

 + be performant,
 + be deployed with a `git push`,
 + serve on https
 + and bonus points if the SSL certificates are auto-generated.

Turns out Google, my new employer, has a very good solution with
[Firebase Hosting](https://firebase.google.com/docs/hosting/).

*Firebase Hosting is production-grade web content hosting for developers. With
Hosting, you can quickly and easily deploy web apps and static content to a
global content-delivery network (CDN) with a single command.*

It serves the pages on https and offers auto-generation of SSL certificates via
[Let's Encrypt](https://letsencrypt.org). It allows me to define redirection
rules to maintain some urls I had on my old blog.

> Can I "push to deploy"?

The only thing it can't do is deploy the generated site when I push the Hugo
sources. To solve that, I wrote a simple
[CircleCI script](https://github.com/dgageot/javabien/blob/master/circle.yml)
that's triggered each time I push an article to Github. It regenerates the full
blog and pushes it to Firebase.

**Yeah to push to deploy!**

So, when are you going to migrate your blog?
