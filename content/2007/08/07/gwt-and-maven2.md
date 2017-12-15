---
title: "Gwt and Maven2"
date: 2007-08-07T12:00:00+01:00
tags: ["gwt","maven"]
---

Trying to use Maven2 to build a GWT project, here is the simplest pom.xml I came up with, starting from <a href="http://jroller.org/xwarzee/entry/maven2_project_to_build_a">Xavier's</a>

The project can be tested in debug mode <strong>with mvn gwt:gwt</strong>. It is tested in deployed mode with <strong>mvn jetty:run-war</strong>

Don't forget to provide the gwt-user.jar in src/main/webapp/WEB-INF/lib.

Code legend:
Blue parts depend on your project and installation path.
Red part is only needed on a Mac.
Green part makes it easier to use the Jetty plugin.

```xml
<project>
  <properties>
    <google.webtoolkit.home><span style="color:blue">
    /Users/david/Applications/java/gwt-mac-1.4.10/</span>
    </google.webtoolkit.home>
    <google.webtoolkit.extrajvmargs>
    -XstartOnFirstThread
    </google.webtoolkit.extrajvmargs>
  </properties>

  <repositories>
      <repository>
          <id>gwt-maven</id>
          <url>http://gwt-maven.googlecode.com/svn/trunk/mavenrepo</url>
      </repository>
  </repositories>

  <pluginRepositories>
      <pluginRepository>
          <id>gwt-maven</id>
          <url>http://gwt-maven.googlecode.com/svn/trunk/mavenrepo</url>
      </pluginRepository>
  </pluginRepositories>

  <build>
    <plugins>
      <plugin>
        <groupId>org.mortbay.jetty</groupId>
        <artifactId>maven-jetty-plugin</artifactId>
      </plugin>
      <plugin>
        <groupId>com.totsp.gwt</groupId>
        <artifactId>maven-googlewebtoolkit2-plugin</artifactId>
        <version>1.5.1</version>
        <configuration>
            <logLevel>ERROR</logLevel>
            <runTarget>com.valtech.planning.Planning/JnfPage.html</runTarget>
            <compileTarget>com.valtech.planning.Planning</compileTarget>
        </configuration>
        <executions>
            <execution>
                <goals>
                    <goal>compile</goal>
                </goals>
            </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

  <dependencies>
    <dependency>
        <groupId>com.google.gwt</groupId>
        <artifactId>gwt-user</artifactId>
        <version>1.4.10</version>
        <scope>provided</scope>
    </dependency>
    <dependency>
        <groupId>com.google.gwt</groupId>
        <artifactId>gwt-servlet</artifactId>
        <version>1.4.10</version>
    </dependency>
  </dependencies>
</project>
```
