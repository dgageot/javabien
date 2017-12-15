---
title: "Serious Fun with Hubot"
date: 2014-06-06T12:00:00+01:00
tags: ["hubot"]
---

For our project, I setup an <a href="https://hubot.github.com/">Hubot</a> on a micro instance on Compute Engine to help us both have fun and do serious stuff.

<blockquote>
  A bot for serious stuff
</blockquote>

For those who don't know Hubot, it's a bot written in CoffeeScript that reacts to commands you send him. We choose to plug it to our Campfire chat room. That way Hubot can tell us when a commit is done on Bitbucket, when Jenkins fails (although Jenkins has been down for months on our project...), when the production is being redeployed with ansible.

<blockquote>
  A bot for fun
</blockquote>

But hubot is not just about work. It's also very handy when you need to translate a word, send a random kitten image to the team or add a mustache to any image. The bot also knows how to congratulate us when somebody behaves <a href="http://knowyourmeme.com/memes/like-a-boss">like a boss</a>

<blockquote>
  "hubot: mustache me"
</blockquote>

![Moustache me](/images/5.jpg#center)

<blockquote>
  Next steps
</blockquote>

On my todo list, I need to teach Hubot to redeploy environnements by himself and monitor our production.
