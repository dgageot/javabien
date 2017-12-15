---
title: "Améliorer la génération WSDL vers Java"
date: 2008-11-28T12:00:00+01:00
tags: ["java","soap","soap"]
---

Chaque stack SOAP Java a ses propres outils pour générer des Stubs Java à partir d'un fichier de description WSDL. A une époque, les outils <a href="http://ws.apache.org/axis/">Axis</a> ou <a href="http://xfire.codehaus.org/">XFire</a> généraient des Stubs franchement différents pour le même WSDL. Maintenant, les outils sont à peu près d'accord sur le format.

La description suivante :

```xml
<complextype name="CredentialsHeader">
    <sequence>
        <element name="username" type="xsd:string"/>
        <element name="password" type="xsd:string"/>
    </sequence>
</complextype>
```

Va générer la classe Java suivante :

```java
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CredentialsHeader", propOrder = {"username", "password"})
public class CredentialsHeader {
    @XmlElement(required = true)
    protected String username;
    @XmlElement(required = true)
    protected String password;

    public String getUsername() {
        return username;
    }
    public void setUsername(String value) {
        this.username = value;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String value) {
        this.password = value;
    }
}
```

Ce POJO est minimaliste : pas de constructeur avec paramètres, pas de <em>toString()</em>...

Résultat, le code client d'appel des WebServices est fastideux avec beaucoup d'appels de setters et les résultats renvoyés ne peuvent pas être simplement dumpés dans la console.

Bien sûr, il est possible d'ajouter tout cela à la main post-génération, ça n'a pas d'impact sur les appels de WebServices, mais c'est fastidieux.

La solution repose sur <a href="https://jaxb2-commons.dev.java.net/">jaxb2-commons</a>. Un ensemble de plugins qui vont enrichir la génération des Stubs.

Prenons un exemple avec <a href="https://metro.dev.java.net/">Metro</a>, la stack SOAP de Sun et un bon vieux script Ant :

```xml
<?xml version="1.0" ?>
<project default="all" basedir=".">
    <taskdef name="wsimport" classname="com.sun.tools.ws.ant.WsImport">
        <classpath>
            <fileset dir="metro/lib">
                    <include name="**/*.jar"/>
             </fileset>
            <fileset dir="plugins">
                    <include name="**/*.jar"/>
             </fileset>
        </classpath>
    </taskdef>

    <target name="all">
        <wsimport xnocompile="true" wsdl="test.wsdl">
            <xjcarg value="-Xvalue-constructor"/>
            <xjcarg value="-Xcommons-lang"/>
        </wsimport>
    </target>
</project>
```

 + Le paramètre <strong>-Xvalue-constructor</strong> permet de générer des constructeurs avec paramètres en plus du constructeur par défaut.
 + Le paramètre <strong>-Xcommons-lang</strong> permet de générer les méthodes <em>equals()</em>, <em>toString()</em> et <em>hashCode()</em> en utilisant <a href="http://commons.apache.org/lang/">apache-commons-lang</a>.
