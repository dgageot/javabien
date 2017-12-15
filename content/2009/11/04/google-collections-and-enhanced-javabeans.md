---
title: "Google collections and enhanced JavaBeans"
date: 2009-11-04T12:00:00+01:00
tags: ["functional","google collections","java"]
---

I'm a big fan of <a href="http://code.google.com/p/google-collections/">Google Collections</a>. Functions and Predicates became my best friends to make Java's syntax a bit functional-like. I like writing things like:

```java
List<Contact> contacts = ...
List<String> toStrings = Lists.transform(contacts, Functions.toStringFunction());
```

and with the help of static imports:

```java
List<String> toStrings = transform(contacts, toStringFunction());
```

If you use out-of-the-box Functions and Predicates, it's a lot of fun. Now, let's say, you want something more useful like:

```java
List<String> names = transform(contacts, Contact.T0_NAME);
```

you need to accommodate with Java's way of writing functions. That is write an inner class:

```java
public class Contact {
...
public static Function<Contact, String> TO_NAME = new Function<Contact, String> {
    public String apply(Contact contact) {
        return contact.getName();
    }
}
```

It's ok for one bean property, but writing functions for all of them is a lot of work.

What if we could write a JavaBean that would generate all these functions for us. Something like that:

```java
public class Contact extends AbstractBean<Contact> {
public static final StringProperty<Contact> NAME = stringValue();
public static final IntegerProperty<Contact> AGE = integerValue();
public static final StringProperty<Contact> EMAIL = stringValue();

public Contact(String name, int age, String email) {
    super(NAME, name, AGE, age, EMAIL, email);
}

public String getName() {
    return get(NAME);
}

public Integer getAge() {
    return get(AGE);
}

public String getEmail() {
    return get(EMAIL);
}
}
```

Now, every property of my bean is also a Function converting a bean instance to it's property value. To be clear:

```java
Contact.NAME is a Function<Contact, String>
Contact.AGE is a Function<Contact, Integer>
Contact.EMAIL is a Function<Contact, String>
```

so that I can write:

```java
List<Contact> contacts = ...
List<String> names = transform(contacts, Contact.NAME);
List<Integer> ages = transform(contacts, Contact.AGE);
```

Nice isn't it?

Now, it can be even cooler. I can write something like that:

```java
Iterable<Contact> david = filter(contacts, NAME.isEqualTo("david"));
... adults = filter(contacts, AGE.isGreaterThan(18));
... babies = filter(contacts, NAME.isEqualTo("baby").and(AGE.isLessThan(1)));
```

My bean properties are also Predicate factories!

With a custom utility class, I can even use a clearer syntax that Google Collection's:

```java
... ages = with(contacts).keep(NAME.isEqualTo("david")).to(AGE).list();
```

There are even more features. All AbstractBeans come with free equals(), hashCode() and compare().

The last neat feature is the ability to write a builder for any bean easily, with only one additional method:
```java
public class Contact extends AbstractBean<Contact> {
...
static <V> BeanBuilder<Contact> with(BeanProperty<Contact, V> property, V value) {
    return new BeanBuilder<Contact>() {
        public Contact createBean(PropertyValues<Contact> values) {
            return new Contact(values.get(Contact.NAME), values.get(Contact.AGE));
        }
    }.with(property, value);
}
```

Now, I can write something like this:

```java
Contact contact = with(NAME, "david").with(AGE, 34).with(EMAIL, "d@g.net").build();
```

<strong>Note, that all of the features are statically typed and don't use reflection.</strong>

What do you think?
