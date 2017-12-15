---
title: "Find out if Guice creates Circular Proxies"
date: 2014-05-02T12:00:00+01:00
tags: ["cycle","guice","proxy"]
---

[Guice] is a smart dependency injection library. Even if one shouldn't have circular dependencies when using IOC, Guice is able to solve the most common cases by hiding beans behind proxies when necessary.

Let's say you'd like Guice to refuse circular dependencies. Just add this line to your (parent) module:

```java
@Override
protected void configure() {
    // ... insert the bindings here

    binder().disableCircularProxies();
}
```

Now Let's you'd just like to print the classes that are proxied by Guice. Use an injection listener to do that:

```java
@Override
protected void configure() {
   // ... insert the bindings here

   bindListener(Matchers.any(), new TypeListener() {
       @Override
       public <I> void hear(TypeLiteral<I> typeLiteral, TypeEncounter<I> typeEncounter) {
           typeEncounter.register((InjectionListener<I>) bean -> {
               if (Scopes.isCircularProxy(bean)) {
                   System.out.println(typeLiteral.getRawType().getName());
               }
           });
       }
   });
}
```
