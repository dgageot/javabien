---
title: "Ansible and Google Compute Engine"
date: 2014-03-31T12:00:00+01:00
tags: ["ansible","google","gce"]
---

I've discovered <a href="http://www.ansible.com/home">Ansible</a> only last week and I'm already a huge fan. Why? It's much simpler that what I've seen with Chef or Puppet. If really fits with my way of working.

When I prepare a machine manually, I type a list of commands in a sequential manner. With Ansible, I simply translate this list of commands into a playbook. A playbook is a list of tasks. Something like that:

```yaml
---
- hosts: gce
  sudo: yes
  tasks:
    - shell: creates=/usr/share/doc/python-apt apt-get update &amp; apt-get install -y python-apt
    - apt: pkg=python-pip
    - apt: pkg=python-pycurl
    - apt: pkg=nginx
    - service: name=nginx state=started
    - apt_repository: repo='deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' state=present
    - apt_repository: repo='deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' state=present
    - apt_key: data="{{ lookup('file', 'files/java/webupd8.key.asc') }}" state=present
    - shell: echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
    - apt: pkg=oracle-java8-installer update_cache=yes state=installed
    - apt: pkg=maven
    - apt: pkg=psmisc
    - apt_key: url=http://docs.mongodb.org/10gen-gpg-key.asc
    - apt_repository: repo='deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' state=present
    - apt: pkg=mongodb-10gen=2.2.3 update_cache=yes
    - service: name=mongodb state=started
```

When these tasks work well, you can refactor the playbook a little bit by forming groups of tasks. Then you can extract theses tasks into named roles. One baby step at a time. Ansible enables this way of working step by step. It's not too strict about the way you organise your project. It's up to you to stop when you think it's good enough.

If you want to prepare a Google Compute Engine instance with Ansible, it's very easy. Create the instance with the Api or the Console. Grab the IP and put it into a hosts file and run a playbook. There's no agent to install on the instance before running Ansible. That's nice.

However, because GCE uses its own set of ssh keys to connect to an instance, here's the kind of <code>ansible.cfg</code> configuration file you have to write before you get started:

```ini
[defaults]
remote_user = YOUR_GCE_USERNAME

[ssh_connection]
ssh_args = -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no -i PATH_TO/google_compute_engine
```

Have fun!
