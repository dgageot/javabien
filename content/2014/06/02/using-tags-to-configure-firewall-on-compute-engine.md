---
title: "Using tags to configure firewall on Compute Engine"
date: 2014-06-02T12:00:00+01:00
tags: ["google","gce"]
---

If you create a new instance on <a href="https://cloud.google.com/products/compute-engine/">Google Compute Engine</a>, below the tags that you can use to describe your instance, you'll see two checkboxes.

![Tags](/images/Screen-Shot-2014-06-02-at-19.22.03.png#center)

<blockquote>
  What does it have to do with tags? Isn't it rather a network thing?
</blockquote>

Well, a nice feature was introduced that lets you create new firewall rules based on tags. Now, you don't have to create a new network description for every single type of machine. One that lets http pass, one that lets mongodb pass... All you have to do is create a single network and activate/deactivate some rules based on tags. When you create a new instance, just add the appropriate tags, and the appropriate ports will be opened.

![Tags](/images/Screen-Shot-2014-06-02-at-19.24.12.png#center)

<blockquote>
  Back to 'Allow HTTP traffic' and 'Allow HTTPS traffic' checkboxes.
</blockquote>

The default network for any Compute Engine is created with two rules that use tags. One lets http traffic pass, the other lets https traffic pass. The two checkboxes are only here as a mean to tag an instance.

<blockquote>
  Have fun!
</blockquote>
