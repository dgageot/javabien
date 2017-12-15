---
title: "Fongo, Mongo, and Jongo Unchained"
date: 2014-02-26T12:00:00+01:00
tags: ["fongo","jongo","mongo","tests"]
---

<a href="http://www.mongodb.org/">MongoDb</a> is a really good database. For a test addict like me it had one small problem. You either had to install a local mongo or use a distant mongo for your tests.

The first option is good because it doesn't rely on the network. But building a java project should be as simple as: Buy a new computer, open a terminal, git clone [repo], mvn clean install. Done. (I guess a windows computer doesn't qualify here...)

The second option is bad because tests shouldn't rely on external resources. It's slow and error-prone.

<blockquote>
  Enters Fongo!
</blockquote>

<a href="https://github.com/fakemongo/fongo">Fongo</a> is an in-memory implementation of mongoDb. Not everything is implemented but it sufficient for most tests.

Here's a test where I connect to an in-memory mongo, create and query documents. So simple!

**MongoJongoFongoTest.java**

```java
import org.jongo.Jongo;
import org.jongo.MongoCollection;
import org.junit.Test;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.github.fakemongo.Fongo;
import com.mongodb.DB;

import static org.assertj.core.api.Assertions.assertThat;

public class MongoJongoFongoTest {
    @Test
    public void test_in_memory_mongodb() {
        DB db = new Fongo("tests").getDB("Database");
        Jongo jongo = new Jongo(db);

        MongoCollection friends = jongo.getCollection("friends");

        friends.insert(
                new Friend("Sheldon"),
                new Friend("Leonard"),
                new Friend("Penny"),
                new Friend("Howard"),
                new Friend("Rajesh"),
                new Friend("Bernadette"),
                new Friend("Amy"));

        assertThat(friends.count()).isEqualTo(7);
        assertThat(friends.findOne("{name: #}", "Sheldon").as(Friend.class)).isNotNull();
        assertThat(friends.findOne("{name: #}", "Ross").as(Friend.class)).isNull();
    }

    static class Friend {
        String name;

        @JsonCreator
        Friend(@JsonProperty("name") String name) {
            this.name = name;
        }
    }
}
```

**pom.xml**

```xml
<dependency>
    <groupId>org.mongodb</groupId>
    <artifactId>mongo-java-driver</artifactId>
    <version>2.11.4</version>
</dependency>
<dependency>
    <groupId>org.jongo</groupId>
    <artifactId>jongo</artifactId>
    <version>1.0</version>
</dependency>
<dependency>
    <groupId>com.github.fakemongo</groupId>
    <artifactId>fongo</artifactId>
    <version>1.3.6</version>
</dependency>
```

To make it even easier to access mongo from Java code, I use <a href="http://jongo.org/">Jongo</a>. It rocks!

Notice also that to connect to a real mongo server, all I need is to change:

```java
DB db = new Fongo("tests").getDB("Database");
```
to

```java
DB db = new MongoClient(HOST).getDB("Database");
```
