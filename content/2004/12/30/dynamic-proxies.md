---
title: "Dynamic Proxies"
date: 2004-12-30T12:00:00+01:00
tags: ["java"]
---

Here is a small example of using dynamic proxies in Java. A proxy wraps any object implementing any interface and takes control of method invocation on this object. This code sample shows how one can wrap a remote RMI object with a proxy that will retry multiple times any method call on this object in case of network error.

```java
import java.lang.reflect.* ;
import java.rmi.Remote ;

public class RetryProxy implements InvocationHandler
{
	private final static int MAX_TRY = 3 ;

	private final Object object ;

	private RetryProxy (Object anObject)
	{
		object = anObject ;
	}

	public static Object newInstance (Object obj, Class anInterface)
	{
		if ((null == obj) || (null == anInterface))
		{
			throw new IllegalArgumentException ("Impossible to create Proxy") ;
		}

		Class[] interfaces = {anInterface} ;

		return Proxy.newProxyInstance ( obj.getClass().getClassLoader(),
								interfaces,
								new RetryProxy (obj)) ;
	}

	public Object invoke (Object proxy, Method m, Object[] args) throws Throwable
	{
		for (int i = 0; i < (MAX_TRY - 1); i++)
		{
			try
			{
				return m.invoke (object, args) ;
			}
			catch (InvocationTargetException ex)
			{
			}
		}

		try
		{
			return m.invoke (object, args) ;
		}
		catch (InvocationTargetException ex)
		{
			throw ex.getTargetException() ;
		}
	}

	public static void main (String[] args)
	{
		// Get the reference to a remote object
		//
		Pingable remoteClient = ... ;

		// Wrap this RMI object into with RetryProxy
		//
		remoteClient = (Pingable) RetryProxy.newInstance (test, Pingable.class) ;

		// Try to ping the remote.
		//
		System.out.println (remoteClient.ping()) ;	// RMI Call
	}
}```
