---
title: "TestNG, la mort de JUnit annoncée ?"
date: 2006-04-13T12:00:00+01:00
tags: ["junit","tests","testNG"]
---

<strong>Il est intéressant de noter que beaucoup de projets XP utilisent JUnit. Pourtant aux <a href="http://www.valtech.com/servlet/ContentServer?pagename=Valtech/Page&assetid=1137684746182">Valtech Days</a>, Christian Bauer, co-créateur d’Hibernate déclarait « <em>JUnit is dead, use TestNG</em> ».</strong> <strong>Quels sont donc les avantages de TestNG ?</strong>

Personnellement, je n’ai pas encore éprouvé le besoin d’améliorer JUnit, alors voici le discours marketing de TestNG :

 + Les tests mis en place avec TestNG n’imposent pas de dépendance à une hiérarchie de classes JUnit. Tout passe par des annotations. Pas de grosse valeur ajoutée et en plus cela nécessite un Java5.

 + Il est possible de grouper les tests par groupes, de gérer l’ordre des tests et de passer certains tests si des tests préliminaires ne sont pas passés. Cela veut dire que l’on met en place une dépendance entre les tests, ce qui n’est pas forcément un bon design et n’en simplifie pas la maintenance et le refactoring.

 + On peut définir un setup et un teardown qui ne sont appelés qu’une fois par classe de test. Encore une fois cela entraine des dépendances entre les tests. Par contre cela permet d’accélérer les tests, ce qui est important pour un projet XP.

 + TestNG propose plusieurs autres raffinements par rapport à JUnit, à vous de comparer… (avec JUnit 3 mais aussi avec JUnit 4)

Si ce n’était pas assez clair, je ne suis pas encore converti.
