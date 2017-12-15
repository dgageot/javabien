---
title: "Use Sonar to Combine Surefire Tests and Failsafe Tests Coverage in a Multi-Module Project"
date: 2012-11-23T12:00:00+01:00
tags: ["coverage","sonar","tests"]
---

As you might already know, using <a href="http://www.sonarsource.org">Sonar</a> one can measure code coverage by Unit Tests (UTs) on a maven project. Even better, in multi-module projects, coverage is aggregated at parent-module's level. That's great!

However, lots of use cases are not covered by this basic behaviour. What if you have UTs in a module covering code in another module? What if a module contains Integration Tests (ITs) that cover, by nature, code in lots of modules? What if those tests are run with maven failsafe plugin?

Turns out Sonar has got all these covered but it's surprisingly difficult to configure correctly. You can <a href="http://www.google.fr/#hl=en&tbo=d&sclient=psy-ab&q=combine+unit+tests+integration+tests+sonar&oq=combine+unit+tests+integration+tests+sonar&gs_l=hp.3...1089.10995.0.11154.44.42.1.0.0.1.357.6588.0j31j8j1.40.0.les%3B..0.0...1c.1.7Uf7g0q9JT8&pbx=1&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&fp=457fdb700a81b575&bpcl=38897761&biw=1287&bih=732">Google for an answer</a>, there are plenty of results, all of which I found mostly useless because they are: outdated, false or full of useless configuration/steps.

So I created my own demonstration project <a href="https://github.com/dgageot/coverage">on GitHub</a>. Let me explain what it does...

It's a two modules maven project with a parent module. Module <strong>coverage-api</strong> contains production code and it's own UTs. Module <strong>coverage-impl</strong> contains more production code, its own UTs, and an IT that covers both modules's code.

If we'd try to compute the coverage manually, we'd find that <strong>coverage-api</strong> is covered at 66.7% by its UTs and at 66.7% by the IT from the other module. <strong>coverage-impl</strong> is covered at 66.7% by its UTs and at 66.7% by the IT. And 100% of all code is covered by at least one test.

<strong>Let's try to configure the project to find the same numbers!</strong>

For <strong>coverage-api/pom.xml</strong>, it's easy, nothing needs to be done.

For <strong>coverage-impl/pom.xml</strong>, we need to make sure that ITS are launched with <em>maven-failsafe-plugin</em>:

```xml
<build>
  <plugins>
    <plugin>
      <artifactId>maven-failsafe-plugin</artifactId>
      <version>2.12.4</version>
      <configuration>
        <argLine>${jacoco.agent.argLine}</argLine>
        <includes>
          <include>**/*TestIntegration.java</include>
        </includes>
      </configuration>
      <executions>
        <execution>
          <goals>
            <goal>integration-test</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
  </plugins>
</build>
```

Notice that we rely on jacoco agent begin configured to collect ITs coverage data. That's done in parent's pom.

For parent module, we make sure that jacoco agent is configured for all child modules. We define a single IT coverage report, in append mode, to aggregate all coverage.

```xml
<properties>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
  <sonar.core.codeCoveragePlugin>jacoco</sonar.core.codeCoveragePlugin>
  <sonar.jacoco.itReportPath>${project.basedir}/../target/jacoco-it.exec</sonar.jacoco.itReportPath>
</properties>

<build>
  <plugins>
    <plugin>
      <groupId>org.jacoco</groupId>
      <artifactId>jacoco-maven-plugin</artifactId>
      <version>0.6.0.201210061924</version>
      <configuration>
        <propertyName>jacoco.agent.argLine</propertyName>
        <destFile>${sonar.jacoco.itReportPath}</destFile>
        <append>true</append>
      </configuration>
      <executions>
        <execution>
          <id>agent</id>
          <goals>
            <goal>prepare-agent</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
  </plugins>
</build>
```

Assuming you run sonar using these commands:

```bash
mvn clean install -Dtest=false -DfailIfNoTests=false
mvn sonar:sonar
```

Here's what you should get if you put the whole thing in Sonar 3.3.1+. Notice that this version of Sonar knows how to sum-up coverage by ITS and coverage by UTs.

![Coverage](/images/coverage.png#center)

Enjoy!
