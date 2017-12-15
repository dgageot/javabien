---
title: "Use Nashorn and WebJars to execute Javascript server-side"
date: 2014-02-19T12:00:00+01:00
tags: ["coffeescript","java 8","nashorn"]
---

Executing javascript inside a browser is one way of leveraging javascript. Node is another way, but on the server-side this time.

<blockquote>Can we do the same thing as Node with Java 8 and Nashorn?</blockquote>

The answer is yes. Let's see how it works.

The following code compiles coffee script to javascript using java code.

**CoffeeToJs.java**

```java
import static java.nio.charset.StandardCharsets.*;
import static javax.script.ScriptContext.*;

import java.io.*;

import net.codestory.http.io.*;

import javax.script.*;

public class CoffeeToJs {
  private final CompiledScript compiledScript;
  private final Bindings bindings;

  public CoffeeToJs() {
    String script = readScript("META-INF/resources/webjars/coffee-script/1.7.0/coffee-script.min.js");

    ScriptEngine nashorn = new ScriptEngineManager().getEngineByName("nashorn");
    try {
      compiledScript = ((Compilable) nashorn).compile(script + "\nCoffeeScript.compile(__source, {bare: true});");
      bindings = nashorn.getBindings(ENGINE_SCOPE);
    } catch (ScriptException e) {
      throw new RuntimeException("Unable to compile script", e);
    }
  }

  private static String readScript(String path) {
    try (InputStream input = ClassLoader.getSystemResourceAsStream(path)) {
      return InputStreams.readString(input, UTF_8);
    } catch (IOException e) {
      throw new RuntimeException("Unable to read " + path, e);
    }
  }

  public synchronized String toJs(String coffee) throws ScriptException {
    bindings.put("__source", coffee);

    return compiledScript.eval(bindings).toString();
  }
}
```

**CoffeeToJsTest.java**

```java
import static org.assertj.core.api.Assertions.*;

import java.io.*;

import org.junit.*;

import javax.script.*;

public class CoffeeToJsTest {
  static CoffeeToJs coffeeToJs = new CoffeeToJs();

  @Test
  public void empty() throws ScriptException {
    String js = new CoffeeToJs().toJs("");

    assertThat(js).isEqualTo("\n");
  }

  @Test
  public void to_javascript() throws ScriptException {
    String js = coffeeToJs.toJs("life=42");

    assertThat(js).isEqualTo("var life;\n\nlife = 42;\n");
  }
}
```

Here's what it does in details:

 + It loads coffee-script.min.js from the classpath. Here, I used a <a href="http://www.webjars.org/">WebJar</a> to import the script into my project
 + Then it create a Nashorn script engine
 + It compiles the coffee-script.min.js once
 + It executes the compile code on the provided coffee script source

Yeah! Server-side javascript in java!
