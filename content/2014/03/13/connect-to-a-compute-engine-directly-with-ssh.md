---
title: "Connect to a Compute Engine instance directly with ssh"
date: 2014-03-13T12:00:00+01:00
tags: ["google","gce","ssh"]
---

On <a href="https://cloud.google.com/products/compute-engine/">Compute Engine</a> it's very simple to connect to an instance using the gcutil command line tool:

```bash
gcutil --project=my_project ssh my_instance
```

But can we connect directly with ssh? That's useful if, say, you need to push to a git repository hosted on that instance. Yes it's easy too. Here's the full command:

```bash
ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no -i $HOME/.ssh/google_compute_engine -A -p 22 $USER@$IP_OF_INSTANCE
```

I didn't make it out, it's printed when I run <code>gcutil ssh my_instance</code>

If, like me, you can barely remember your own phone number, time has come to dump all these flags to a <code>.ssh/config</code> file:

```bash
Host nickname
    HostName $IP_OF_INSTANCE
    Port 22
    User $USER
    UserKnownHostsFile /dev/null
    CheckHostIP no
    StrictHostKeyChecking no
    IdentityFile ~/.ssh/google_compute_engine
```

And now it's as simple as:

```bash
ssh nickname
```
