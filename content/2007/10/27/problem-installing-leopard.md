---
title: "Problem installing Leopard"
date: 2007-10-27T12:00:00+01:00
tags: ["osx"]
---

I installed Leopard yesterday. The good news is that its really beautiful and that it seems to add a lot of improvements. The bad news is that it removed admin rights to my user. It seems funny but because you need admin rights to give admin rights, well ...

Here is the solution :

 + Boot in single user mode. (press AppleKey + S at startup)
 + Add your user to /private/etc/sudoers
 + Reboot
 + From a terminal, add your user to Admin group with this command
<code>sudo dscl . append /Groups/admin GroupMembership myusername</code>
 + Quit and Open Preferencies to check that your user now has admin rights.
 + Remove your user from /private/etc/sudoers. Being in admin group is sufficent
