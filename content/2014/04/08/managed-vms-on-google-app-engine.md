---
title: "Managed Vms on Google App Engine"
date: 2014-04-08T12:00:00+01:00
tags: ["google","app engine"]
---

One thing developers are afraid of with <a href="https://appengine.google.com/">Google App Engine</a> is that it tells them which language and which Api they should use. Some are supported by the platform. Some aren't.

Well that's over. App Engine can now spawn Compute Engine VMs on demand. It's called <a href="https://developers.google.com/cloud/managed-vms">Managed VMs</a>.

No more "<em>Is it supported by App Engine?</em>" question.

<blockquote>
  How does it work?
</blockquote>

 + You configure a VM with whatever framework you want, Java 8, C++, you name it.
 + You still have full root access on the VM.
 + You still have access to all core App Engine services such as Datastore, Task Queues, and Memcache.
 + You get SSL termination and Page speed proxy for free.
 + New VMs are started on demand to respond to all the queries.
 + VMs are stopped when the number of requests decreases.

Here's a <a href="https://www.youtube.com/watch?v=_IeIrQFIyyU&amp;feature=youtu.be">little demo</a>

<blockquote>
  Why is it important?
</blockquote>

This move really blurs the frontier between IaaS ans PaaS. In fact, using pure Iaas will become less and less common. You'll be able to fully control the runtime and type of machine your application is using. And at the same time leverage all the services Google offers.

VMs become a very small box in the big picture.
