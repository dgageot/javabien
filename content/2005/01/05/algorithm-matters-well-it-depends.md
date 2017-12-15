---
title: "Algorithm matters? Well it depends..."
date: 2005-01-05T12:00:00+01:00
tags: ["algorithm"]
---

On my [previous post]({{< relref "2005/01/04/algorithm-matters.md" >}}), I showed that using the best algorithm to solve a problem is very important. The example showed a nice algorithm 35x quicker than the simple implementation. However, the post also says that the algorithm is not the only parameter in execution time.

I you recall the example, data are not read from a database or a file so the algorithm represents 100% of the computation time. In the real world, you would read data from outside and the computation would be far quicker than the retrieval. I've got another example of this principle. It will show beginners that they shouldn't optimize too early and to advanced that they should focus on what's really taking time.

One of the first thing we learn on JAVA classes is recursion. We learn how to compute n! using recursion or standard for(;;) loop. Let's think of a piece of code that would give all words N letters long being of combination of L letters. We'll have to print L^N values (which can be a huge number). One can solve this problem with recursion of a standard loop with some kind of stack.

Here is the code:

```java
import java.util.* ;

public class Test
{
	private final static char[] letters = {'A', 'B', 'C', 'D'} ;
	private final static int NB_CHOICES = letters.length ;
	private final static int LEN = 10 ;

	public Test()
	{
	}

	private static void add (char[] aWord, int anIndex, Collection allWords)
	{
		if (anIndex == LEN)
		{
			//allWords.add (new String (aWord)) ;	// Found a word
		}
		else
		{
			for (int i = 0; i < NB_CHOICES; i++)
			{
				aWord [anIndex] = letters [i] ;
				add (aWord, anIndex + 1, allWords) ;
			}
		}
	}

	public Collection algo1()
	{
		char[] buf = new char [LEN] ;

		Collection allWords = new ArrayList() ;

		add (buf, 0, allWords) ;

		return allWords ;
	}

	public Collection algo2()
	{
		Collection allWords = new ArrayList() ;

		char[] buf = new char [LEN] ;
		int[] steps = new int [LEN] ;
		int position = 0 ;

		do
		{
			int step = steps [position] ;

			if (step >= NB_CHOICES)
			{
				if (--position >= 0)
				{
					steps [position]++ ;
				}
			}
			else
			{
				buf [position] = letters [step] ;
				if ((position + 1) < LEN)
				{
					position++ ;
					steps [position] = 0 ;
				}
				else
				{
					//allWords.add (new String (buf)) ;	// Found a word
					steps [position]++ ;
				}
			}
		}
		while (position >= 0) ;

		return allWords ;
	}

	public static void main (String[] args)
	{
		Test test = new Test() ;

		long date1 = System.currentTimeMillis() ;
		Collection set1 = test.algo1() ;
		long date2 = System.currentTimeMillis() ;
		Collection set2 = test.algo2() ;
		long date3 = System.currentTimeMillis() ;
		System.out.println (date2 - date1) ;
		System.out.println (date3 - date2) ;
		System.out.println (set1.size()) ;
		System.out.println (set2.size()) ;
		System.out.println (set1.equals (set2)) ;
	}
}
```

So the second algorithm is twice as fast with this set of values. However, if we need to create a new String() object for each word, we have these time:

 + recursion: 1610ms
 + loop: 1187ms
 + This is only a 26% gain.

So should we choose the second algorithm that is not easy to write nor to read or the first one?
