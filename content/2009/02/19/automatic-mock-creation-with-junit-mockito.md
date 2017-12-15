---
title: "Automatic mock creation with JUnit & Mockito"
date: 2009-02-19T12:00:00+01:00
tags: ["junit","mockito","tdd"]
---

<a href="http://code.google.com/p/mockito/">Mockito</a> is really a great mocking framework. It is based on a powerful stubbing and verification mechanism. Using it is as simple as this:

```java
import static org.mockito.Mockito.*;

List mockedList = mock(List.class);

mockedList.add("one");
mockedList.clear();

verify(mockedList).add("one");
verify(mockedList).clear();
```

A handy tool provided by Mockito is a custom JUnit runner that automatically creates mock for fields tagged with @Mock annotation:

```java
@RunWith(MockitoJUnit44Runner.class)
public class ArticleManagerTest {
    @Mock private ArticleCalculator calculator;
    @Mock private ArticleDatabase database;
    @Mock private UserProvider userProvider;

    private ArticleManager manager;
```

In our team, we came up with an even simpler solution. All mock names should start with <em>mock</em> to ease test code readability. So we coded a custom Runner that doesn't need the @Mock annotation.

```java
@RunWith(AutoMockRunner.class)
public class ArticleManagerTest {
    private ArticleCalculator mockCalculator;
    private ArticleDatabase mockDatabase;
    private UserProvider mockUserProvider;

    private ArticleManager manager;
```

Here is the runner implementation:

```java
public class AutoMockRunner extends BlockJUnit4ClassRunner {
  public AutoMockRunner(Class< ?> clazz) throws InitializationError {
    super(clazz);
  }

  @Override
  protected Object createTest() throws Exception {
    Object clazz = super.createTest();

    for (Class< ?> c = clazz.getClass(); c != Object.class; c = clazz.getSuperclass()) {
      scan(testClass, c);
    }

    return clazz;
  }

  private static void scan(Object testClass, Class< ?> clazz) {
    for (Field field : clazz.getDeclaredFields()) {
      if (field.getName().startsWith("mock")) {
        Object mock = Mockito.mock(field.getType(), field.getName());

        try {
          if (field.isAccessible()) {
            field.set(testClass, mock);
          } else {
            field.setAccessible(true);
            try {
              field.set(testClass, mock);
            } finally {
              field.setAccessible(false);
            }
          }
        } catch (IllegalAccessException e) {
          e.printStackTrace();
        }
      }
    }
  }
}
```
