---
title: "Homebrew service manager"
date: 2014-02-27T12:00:00+01:00
tags: ["brew","osx"]
---

If you have a Mac, there's a chance you use <a href="http://brew.sh/">Homebrew</a>, the "missing package manager for OS X".

It's by far the best package manager I've used those years on OS X. Not to mention the fact that its based on git. Participating to the effort of creating as many packages as possible is as simple as submitting a PR on a simple ruby file.

For example <a href="https://github.com/Homebrew/homebrew/blob/master/Library/Formula/sonar.rb">here</a>'s the "formula" for SonarQube that I contributed to.

On most unixes, alongside the package manager, there's a tool to start daemon services, install and uninstall them. There was no such thing with Homebrew until <code>brew services</code> command was added.

```bash
brew services
```

```bash
$brew services
usage: [sudo] brew services [--help] <command> [<formula>]

Small wrapper around `launchctl` for supported formulae, commands available:
   cleanup Get rid of stale services and unused plists
   list    List all services managed by `brew services`
   restart Gracefully restart selected service
   start   Start selected service
   stop    Stop selected service

Options, sudo and paths:

  sudo   When run as root, operates on /Library/LaunchDaemons (run at boot!)
  Run at boot:  /Library/LaunchDaemons
  Run at login: /Users/dgageot/Library/LaunchAgents
```

<blockquote>
  Want to install SonarQube on your laptop?
</blockquote>

```bash
brew install sonar
brew services start sonar
```

<blockquote>
  Want to install MongoDB on your laptop?
</blockquote>

```bash
brew install mongodb
brew services start mongodb
```

You got the pattern...
