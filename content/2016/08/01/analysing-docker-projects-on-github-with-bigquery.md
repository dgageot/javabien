---
title: "Analysing Docker projects on Github with BigQuery"
date: 2016-08-01T12:00:00+01:00
tags: []
---

Maybe you know that the Github public archive can be analyzed with [Google BigQuery](https://cloud.google.com/bigquery/public-data/github). That's 3Tb of data! This helped people run analysis on [languages usage](http://glaforge.appspot.com/article/what-can-we-learn-from-million-lines-of-groovy-code-on-github) or [framework popularity](https://medium.com/google-cloud/imports-in-java-from-2013-to-2016-winners-and-losers-2a9640056022#.g3242cpki).

I wanted to produce similar results with projects using Docker. But what's a project using Docker? For this article, I will consider a Docker project, a project that has a least one `Dockerfile` file.

So, why don't we start by counting the number of `Dockerfile` files?

## Count the Docker projects

The following query lists all files on a `master` branch that contain `Dockerfile` in their name. That's not perfect but should be good enough for statistics.

```sql
SELECT count(*)
FROM [bigquery-public-data:github_repos.files]
WHERE path CONTAINS 'Dockerfile'
AND ref = 'refs/heads/master'
```

The number is: `281,212`. That's quite a lot! About 1% of all 2.9M Github projects.

## Compare all the things!

We could compare it to the number of:

 + `pom.xml`: 840,328
 + `travis.yml`: 2,187,893
 + `Makefile`: 18,103,807
 + `README.md`: 10,774,468

A LOT of project seem to have a LOT of Makefiles! For example, [shengshanbai/mini2440_buildroot](https://github.com/shengshanbai/mini2440_buildroot) contains `8628` Makefiles.

```sql
SELECT repo_name, count(*) count
FROM (
  SELECT repo_name
  FROM [bigquery-public-data:github_repos.files]
  WHERE path CONTAINS 'Makefile'
  AND ref = 'refs/heads/master'
)
GROUP BY repo_name
ORDER BY count DESC
LIMIT 1
```

## Which base images are most used?

Now, it would be interesting to know which base images are used most often. There's two ways of doing that. We can count the occurrences of each distinct `FROM` clause. Or we could group by image name, without the tag.

Let's try both!

To make the next queries easier to write, I've created a view called `dockerfiles` with this query. This view contains the `id` of every Dockerfile we found:

```sql
SELECT id
FROM [bigquery-public-data:github_repos.files]
WHERE path CONTAINS 'Dockerfile'
AND ref = 'refs/heads/master'
```

And another view called `dockerfiles_content` that contains the actual content of all those Dockerfiles:

```sql
SELECT contents.content as dockerfile
FROM [code-story-blog:github.dockerfiles] as dockerfiles
JOIN [bigquery-public-data:github_repos.contents] as contents
ON dockerfiles.id = contents.id
```

Now let's extract the images names and counts:

```sql
SELECT RTRIM(LTRIM(SUBSTR(line, 5))) as image, count(*) as count
FROM (
  SELECT SPLIT(dockerfile, '\n') as line
  FROM [code-story-blog:github.dockerfiles_content]
  HAVING LEFT(line, 5) = 'FROM '
)
GROUP BY image
ORDER BY count DESC
LIMIT 10
```

| position | image | count |
|----|---------------|-------|
|  1 | ubuntu:14.04  | 26746 |
|  2 | debian:jessie | 14031 |	 
|  3 | scratch       | 11891 |
|  4 | busybox       |  8064 |
|  5 | ubuntu:trusty |  7516 |	 
|  6 | ubuntu        |  5597 |
|  7 | golang:1.4    |  3395 |
|  8 | ubuntu:latest |  3383 |
|  9 | debian:wheezy |  2897 |	 
| 10 | ubuntu:12.04  |  2545 |

Old Ubuntus are used a lot! The first `alpine` image is in 30th position. That needs to be improved! (See [Alpine Based Docker Images Make a Difference in Real World Apps](http://nickjanetakis.com/blog/alpine-based-docker-images-make-a-difference-in-real-world-apps))

Now, what if we ignore the tags:

Let's define an `images` view with all image names:

```sql
SELECT RTRIM(LTRIM(SUBSTR(line, 5))) as line_group.base_image
FROM (
  SELECT SPLIT(dockerfile, '\n') as line
  FROM [code-story-blog:github.dockerfiles_content]
  HAVING LEFT(line, 5) = 'FROM '
)
```

And count the occurrences of each image name:

```sql
SELECT image, count(*) as count
FROM (
  SELECT FIRST(SPLIT(line_group.base_image, ':')) as image
  FROM [code-story-blog:github.images]
)
GROUP BY image
ORDER BY count DESC
LIMIT 15
```

| position | image | count |
|----|---------------|-------|
| 1	| ubuntu	| 54453 |
| 2	| debian	| 23079 |
| 3	| golang	| 13127	|
| 4	| scratch	| 11894	|
| 5	| busybox	| 11059	|
| 6	| centos	| 10087	|
| 7	| fedora	| 7340|
| 8	| node	| 6764 |
| 9	| python	| 6239 |
| 10	| java	| 6102 |
| 11	| alpine	| 4945 |
| 12	| nginx	| 3074 |
| 13	| redis	| 2970 |
| 14	| php	| 2611 |
| 15	| brimstone/ubuntu | 2536	|

Ubuntu still leads and it's good to see that people also use a lot the base images created especially for each language: Go, Node, Python and Java base images make it into the top 10.

OK, that's it for counting. One can get nice information by counting but can we do better? For example, could we compare Dockerfiles with the [best practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)?

One of those best practices says we should use `COPY` over `ADD`.

## ADD or COPY?

I tried to count the number of `ADD` and `COPY` commands. Clearly, the number of `COPY` should be higher since `ADD` should be used for only [very specific cases](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/add-or-copy). But since `ADD` also does what `COPY` does, people tend to overuse `ADD`.

That's easy to check!

We already have a view called `dockerfiles_content` that contains all the lines of all the Dockerfiles. Let's extract the lines that start with `ADD ` or `COPY ` and count the occurrences of both:

```sql
SELECT command, count(*) as count
FROM (
  SELECT first(split(line, ' ')) as command
  FROM (
    SELECT SPLIT(dockerfile, '\n') as line
    FROM [code-story-blog:github.dockerfiles_content]
    HAVING LEFT(line, 5) = 'COPY ' || LEFT(line, 4) = 'ADD '
  )
)
GROUP BY command
```

And here's the result:

|command |  count |
|--------|--------|
| ADD	 | 101042 |
| COPY	 |  65066 |

Clearly, too many `ADD`s! We could analyze the file names passed to `ADD` and check that they are valid urls or tarball files. That would give us the percentage of valid usages. I let that exercise to my beloved readers!

# COPY or ADD after USER?

[Sebastian](https://github.com/thaJeztah), a colleague of mine, asked me to search for a well known bug pattern. Because of a bug / bad decision during implementation of `COPY` and `ADD`, those directives don't follow `USER` directives. So files are not added with ownership of the `USER`, resulting in people having to `RUN chown` afterwards, which balloons the image size.

Le's see what we can do...

```sql
SELECT count(*)
FROM (
  SELECT INSTR(dockerfile, '\nCOPY ') as copy, INSTR(dockerfile, '\nADD ') as add, INSTR(dockerfile, '\nUSER ') as user
  FROM [code-story-blog:github.dockerfiles_content]
  HAVING (user != 0) AND (copy != 0 OR add != 0) AND (user < copy OR user < add)
)
```

That's `4,254` out of `281,212` Dockerfiles (1.5%). Out of those `4,254`, `854` seem to run a `chmod` afterwards.

That's it for today! I hope this will motivate you to either run similar analysis or to improve your Dockerfiles!
