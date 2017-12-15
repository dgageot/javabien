---
title: "Post on Campfire with Ansible"
date: 2014-06-10T12:00:00+01:00
tags: ["ansible","campfire","hubot"]
---

If you started using <a href="https://hubot.github.com/">Hubot</a> and <a href="https://campfirenow.com/">Campfire</a> after yesterday's [post]({{< relref "2014/06/06/serious-fun-with-hubot.md" >}}), here's a snippet that you might find useful.

On our project, we prepare our cloud vms and deploy our applications with <a href="http://www.ansible.com/home">Ansible</a>. Anybody can deploy at any time so it's handy to tell the team members that a redeploy is in progress and that they don't have to do it. Our Hubot is in charge of telling everybody the actions taken on our different platforms. In fact, it's our Ansible playbook that connects to Campfire as Hubot.

Here's the playbook task we use:

```yaml
---
- hosts: vms
  vars:
    branch: master
    target: prod
    token: CAMPFIRE_USER_TOKEN
    subscription: CAMPFIRE_ACCONT
    room: ROOM_ID
  tasks:
    - name: Notify the team that a redeploy is going on
      campfire: subscription={{subscription}} token={{token}} room={{room}} msg="Somebody is redeploying the {{target}} from branch [{{branch}}]"
    - name: Redeploy
      ...
    - name: Notify the team that a redeploy was done
      campfire: subscription={{subscription}} token={{token}} room={{room}} msg="The {{target}} was redeployed from branch [{{branch}}]"
```

<blockquote>
  That's it. Simple but useful
</blockquote>
