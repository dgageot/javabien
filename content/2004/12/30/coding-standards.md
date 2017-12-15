---
title: "coding standards"
date: 2004-12-30T12:00:00+01:00
tags: ["coding standards"]
---

Each developer has its own view on coding standards. What about you ?

<strong>Do you prefer this syntax :</strong>

```java
int arrayIndex = 1 ;
boolean isOk = true ;

if (isOk)
{
  doSomething() ;
}
else if (1 == arrayIndex)
{
  doSomethingElse() ;
}

public static boolean contains (int[] anArray, int aValue)
{
  for (int i = anArray.length - 1; i >= 0; i--)
  {
    if (anArray [i] == aValue)
    {
      return true ;
    }
  }
  return false ;
}
```

<strong>or this one :</strong>

```java
int arrayIndex = 1;
boolean isOk;
isOk=true;
if (isOk == true) {
doSomething();
} else if (arrayIndex==1) {
doSomethingElse();
}

public
static
boolean
contains (int[] anArray, int aValue) {
boolean found;
for (int i = anArray.length-1; i>=0; i--) {
if (aValue==anArray[i]) {
found=true;
break;
}
return found;
}
```

I've been using the former for a long time now (on JAVA and C/C++) and I couldn't change my habits so easily.
