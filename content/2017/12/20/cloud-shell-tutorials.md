---
title: "Google Cloud Shell tutorials"
date: 2017-12-20T16:47:00+01:00
tags: ["hugo","google","cloud shell"]
---

Tutorials are crucial to help us learn new tools / languages / services.
I'm sure all of you have either followed a tutorial or written one. Or both.

When it comes to coding tutorials, there's a tedious preliminary step required
to install the tools before anything fun can be done. That's not time well
spent, especially if 20 of us are in a conference room downloading gigantic
files from Internet.

> "Maven/Npm/Docker is downloading the Internet" anyone?

Spending half an hour setting everything up is half an hour not dedicated to
learning something new.

> Enters Google Cloud Shell

[Google Cloud Shell](https://cloud.google.com/shell/docs/) has been there for
a while but it hasn't stop improving. It's an online shell environment from
which you can use any of the pre-installed tools or install new ones.
It comes with java, go, python, node, docker, maven, gradle, npm, vim, git, php,
ruby, .Net Core, gcloud CLI. And more...

You can of course store your own files there. They will there next time
you open Cloud Shell. In fact, thanks to tmux, all your tabs will be there
next time. (Some people abuse [tabs](https://blog.trello.com/too-many-browser-tabs)).
Sweet.

Now everyone can use the same baseline environment. That helps start actual
tutorials way quicker.

> A "magic" button to Open Cloud Shell

The neatest way to start a tutorial is to click on the "Open in Cloud Shell"
button that anybody can add on their GitHub or BitBucket repositories.

![Open in Google Cloud Shell](/images/open-cloud-shell.png#center)

Clicking on such a button will bring you to a new Cloud Shell tab. It'll
`git clone` the project. And it'll open an online code editor so that you start
coding right away.

I love it! Learn more [here](https://cloud.google.com/shell/docs/open-in-cloud-shell).

> Wait! It gets even better

Another thing this button can do is start a multi-steps tutorial alongside
the code editor so that you are guided all the way. It will tell you
on which UI to click, which command to type and what to expect out of it.
This kind of tutorial, anybody can write. It's a simple Markdown, stored in your
project, with specific markup for Cloud Shell.

![Sample tutorial](/images/tutorial.png#center)

> I wanna try now!

Here, on my [blog's sources repository](https://github.com/dgageot/javabien),
I configured a very basic tutorial to get started with Hugo. Just look for the
*Open in Google Cloud Shell* button.

**Hope this'll make you want to write more tutorials!**
