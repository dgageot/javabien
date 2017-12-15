---
title: "Algorithm matters !"
date: 2005-01-04T12:00:00+01:00
tags: ["algorithm"]
---

For a project, i had to write a piece of code that would count for each day of a year how many classrooms of a university are used. We know the start day of use and the end days of use for each classroom. There can be millions of use for periods from 1 day to the whole year. The first algorithm is came up with was this one :

```java
int[] used = new int [SIZE] ;

for (int i = 0; i < N; i++)
{
	int start = starts [i] ;
	int end = ends [i] ;

	for (int j = start; j <= end; j++)
	{
		used [j]++ ;
	}
}
```

Then I remembered some optimizing tips that my father's got from his job at <a href="http://en.wikipedia.org/wiki/Control_Data_Corporation">Control Data</a> years ago and I wrote this piece of code :

```java
int[] used = new int [SIZE + 1] ;	// HACK
for (int i = 0; i < N; i++)
{
	used [starts [i]]++ ;
	used [ends [i] + 1]-- ;
}

int add = used [0] ;
for (int i = 1; i < SIZE; i++)
{
	add += used [i] ;
	used [i] = add ;
}
```

The second code sample is 35x faster than the first one when SIZE is 365 and N is 10000000. The difference is huge but the time taken by the first code is still good enough. Memory access was more expensive on a Control Data machine than nowadays...
