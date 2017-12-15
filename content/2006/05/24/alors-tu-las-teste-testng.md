---
title: "Alors tu l'as testé TestNG ?"
date: 2006-05-24T12:00:00+01:00
tags: ["tests","testNG"]
---

**Mon précédent article parle de TestNG et compare ses fonctionnalités avec celles de JUnit. J'ai écris cet article sans tester TestNG et je m'étais donc promis de l'utiliser pour mieux juger.**

*Alors tu l'as testé TestNG ?*

> Et bien, je dois avouer que non.

*Pourquoi ?*

> Tout simplement, je constate que JUnit répond à tous mes besoins. Le code des TestCase est clair et les tests sont complètement isolés les uns des autres donc simplissimes à remanier.

*Tu peux faire pareil avec TestNG et même plus !*

> Oui, je sais.

*Et pourquoi ne pas le tester alors ?*

> J'ai mes petites habitudes et JUnit est intégré à tous mes outils (Eclipse, Maven, ...). Pourquoi passer du temps à remplacer un outil qui répond à mes besoins et qui n'est plus qu'une commodité ?

Un avantage que je vois à TestNG est de réduire la durée des tests en mettant en évitant de répéter certaines phases d'initialisation à chaque test. Cependant, pour vraiment réglr le problème, il faut changer les frameworks que l'on met en oeuvre, pas l'outil de test. Par exemple, je préfère tester un POJO que de déployer un EJB avec toute la phase d'initialisation qui précède.
