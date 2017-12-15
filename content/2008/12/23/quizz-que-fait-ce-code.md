---
title: "Quizz : que fait ce code ?"
date: 2008-12-23T12:00:00+01:00
tags: ["java","quizz"]
---

Quizz : Que fait cette méthode ? Question subsidiaire : comment rendre le code plus lisible (en Java) ?

```java
public static <D, R> List<R> inParallel(int nbThreads, List<D> dataList,
final Function<D, R> dataToAction) {
  Function<D, Callable<R>> dataToCallable = new Function<D, Callable<R>>() {
    @Override
    public Callable<R> apply(final D data) {
      return new Callable<R>() {
        @Override
        public R call() {
          return dataToAction.apply(data);
        }
      };
    }
  };

  Function<Future<R>, R> futureToResult = new Function<Future<R>, R>() {
    @Override
    public R apply(Future<R> future) {
      try {
        return future.get();
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    }
  };

  ExecutorService executorService = Executors.newFixedThreadPool(nbThreads);
  try {
    List<Callable<R>> actions = Lists.transform(dataList, dataToCallable);

    List<Future<R>> results = executorService.invokeAll(actions);

    return Lists.transform(results, futureToResult);
  } catch (InterruptedException e) {
    throw new RuntimeException(e);
  } finally {
    executorService.shutdown();
  }
}
```
