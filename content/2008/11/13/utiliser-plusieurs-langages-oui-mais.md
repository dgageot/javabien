---
title: "Utiliser plusieurs langages. Oui, mais..."
date: 2008-11-13T12:00:00+01:00
tags: ["industrialisation","langages","outils"]
---

S'il est de plus en plus admis que l'utilisation de plusieurs langages est un réflexe de bon développpeur,  j'ai l'impression qu'il n'existe pas beaucoup d'outillage pour faire ça sérieusement. Par sérieusement, j'entends : gestion de configuration unifiée, environnement de développement unifié, intégration continue commune, gestion des dépendances, tests fit, ...

Certains points sont plus faciles à résoudre que d'autres. Ainsi, pour la gestion de configuration, s'il est quasi impossible de trouver un outil intégré à tous les IDE de référence de chaque langage, il est par contre trivial d'utiliser un outil externe.

D'autres points sont plus complexes. Chaque langage a son propre système de makefile, que ce soit Ant, Maven, Nant, Rake... Il est possible de tout faire avec un bon vieux Ant ou make mais l'on voit bien que l'introduction d'un nouveau langage a des impacts non négligeables sur toute la chaîne et qu'il faudra mettre de coté certains outils spécialisés au profit d'autres outils plus généralistes donc à priori plus lourds à mettre en oeuvre.

Tout est une question d'équilibre et de temps disponible pour trouver cet équilibre. Pas étonnant que beaucoup d'équipes préfèrent s'en tenir à un seul langage par projet.

De mon coté, je suis en train de mélanger du C#, du Java, du RoR et des langages de scirpts (Groovy ou JRuby). Je cherche encore la bonne façon de le faire...
