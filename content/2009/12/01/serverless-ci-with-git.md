---
title: "Serverless Continuous Integration with Git"
date: 2009-12-01T12:00:00+01:00
tags: ["continuous integration","git"]
---

<strong>"Why use a continuous integration server?"</strong>

That's the question we ask at <a href="http://www.algodeal.com">Algodeal</a>. Having spent years preaching for each team to use a CI server, we installed and used <a href="https://hudson.dev.java.net/">Hudson</a> since the very beginning of the project. However, it's been months since anybody looked at the Hudson dashboard. Every commit breaks the build. And you now what? Nobody cares

<strong>How did it happen?</strong>

The key problem is the time wasted maintaining and Hudson server. Every brick mandatory to the build needs to be installed on the server. Our product relies on (unfortunately) latex, mono and a few R packages. The CI server needs to be up to date always, rebooted sometimes, cleaned more often than never.

Why spend time maintaining a CI server when we could make sure the tests pass locally before pushing to the shared repository?

<em>Decision made</em>: Small aware team + quick build = Bye Hudson! And don't even take a single second to unplug it.

<strong>We've got a situation</strong>

As time goes by, as tests are written, a build gets slower and slower. One minute, then two, then five. Running all the tests locally becomes a pain. It's tempting to push to a CI server without running the tests before and wait for the results drinking a coffee. Here's the choice: either stare at maven for 5 minutes or push broken code.

<strong>Arms race</strong>

We don't want to push broken code. We don't want to waste time staring a the tests. So should we setup a two phases commit with two CI servers? For example TeamCity proposes a remote private build feature which guarantees an unbreakable build timeline. This looks like an arms race lost in advance. Soon we would have a build farm to maintain. Scary!

<strong>Reduce the build duration</strong>

Let's do a root cause analysis instead of putting money and time on a build farm. Let's quicken the build. After a few days, some black magic (a future post), our build was reduced from more than 5 minutes to less than 2 minutes. We can breath again. The main question however still remains. How not to use a CI server in the long term and not suffer the increasing time lost staring at the builds locally?

<strong>Here comes Git</strong>

At Algodeal, we choose git a year ago. Its stability and ease of maintenance are strong advocates. Even if daily usage is a bit odd given the bad front-ends available.

Reading "<a href="http://www-cs-students.stanford.edu/~blynn/gitmagic/">Git Magic</a>", I realized it would be so simple to setup a private local build similar to TeamCity's. Without any server! We'd clone our working directory, run the build from the clone and commit only in case of success.

With a different version management system, we'd face two problems: How long to duplicate the whole project if it becomes large? Once the changes are pushed to the repository, how does the working directory "knows" it's been committed?

With git, it's a piece of cake. First, we 'git clone' the working directory to another folder. Git does the copy *very* quickly. Next times, we don't need to clone. Just tell git get the deltas. Net result: instant cloning. Impressive.

What about the consistency? Doing a simple 'git pull' from the working directory will realize, using delta's digests, that the changes where already pushed on the shared repository. Nothing to do. Impressive again.

Of course, while the build is running in the second directory, we can keep on working on the code. No need to wait.

<strong>The ultimate private build?</strong>

We now have a private build with no maintenance, no additional installation, not dependent on the IDE, ran with a single command line. No more broken build in the shared repository. We can recycle our CI server.

Yes. You've heard well. We've just built a serverless CI. Every additional feature of a real CI server is noise to me.

<strong>The Recipe</strong>

For the more curious of you, here is the script:

```bash
#!/bin/bash
if [ 0 -eq `git remote -v | grep -c push` ]; then
  REMOTE_REPO=`git remote -v | sed 's/origin//'`
else
  REMOTE_REPO=`git remote -v | grep "(push)" | sed 's/origin//' | sed 's/(push)//'`
fi

if [ ! -z "$1" ]; then
  git add .
  git commit -a -m "$1"
fi

git pull

if [ ! -d ".privatebuild" ]; then
  git clone . .privatebuild
fi

cd .privatebuild
git clean -df
git pull

if [ -e "pom.xml" ]; then
  mvn clean install

  if [ $? -eq 0 ]; then
    echo "Publishing to: $REMOTE_REPO"
    git push $REMOTE_REPO master
  else
    echo "Unable to build"
    exit $?
  fi
fi
```
