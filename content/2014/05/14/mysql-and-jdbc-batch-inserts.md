---
title: "MySQL and jdbc batch inserts"
date: 2014-05-14T12:00:00+01:00
tags: ["gcp","jdbc","mysql"]
---

I was doing some benchmarks on MySQL. Both locally and on <a href="https://developers.google.com/cloud-sql/">Google Cloud SQL</a>. And one performance issue struck me.

<blockquote>
  Batch inserts are as slow as individual inserts
</blockquote>

What it means basically is if you insert 10,000 rows, one row at a time or 10,000 in a batch, it takes about the same time. You pay a server round-trip for each row. How uncool is that? I've never seen a database behave this way. I'm already not a big SQL fan. This doesn't help me become one.

Turns out there's an easy fix, that is not activated by default by Connector/J, the MySQL jdbc driver. Add <code>rewriteBatchedStatements=true</code> to the connection properties and there you go, the batch is executed in batch mode with a single round-trip to the server. That's a huge improvement.

<blockquote>
  Why on Earth is it not the default?
</blockquote>

I don't have a good answer to this question. I've got a bad answer though: When values are sent in batch, all values must fit into the <code>max_allowed_packet</code> envelope. If it doesn't fit, the query will fail. So, it's safer to let each row fit than try to fit all rows.

A good implementation would activate this behaviour by default, get rid of the  <code>max_allowed_packet</code> altogether and use as many server round-trip (one per N rows, not one per row) as needed to send all the data.

<blockquote>
  Well at least I solved my problem...
</blockquote>

Yes and No. Yes, I solved this batch insert counterintuitive behaviour. No, every round trip to the server is still very long. Specially on the Cloud Platform, whether I use Google Cloud SQL or my own SQL hosted on a Compute Engine instance.

Maybe I need to search for some more counterintuitive magic property!
