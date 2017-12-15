---
title: "Troisième rencontre du Paris Java User Group"
date: 2008-04-09T12:00:00+01:00
tags: ["jug","performances"]
---

Hier soir a eu lieu la troisième rencontre du <a href="http://www.parisjug.org/index.html">Paris Java User Group (Paris JUG)</a> sur le thème des performances Java. Ce fut un événement passionnant, animé par <a href="http://www.parisjug.org/meetings/20080408/presentation.html">Kirk Pepperdine</a>.

<b>Essayons de résumer la présentation :</b>

Les performances ont toujours été et seront toujours un problème. Dès que le hardware devient suffisamment puissant pour faire tourner le software, un nouveau software apportant de nouvelles fonctions remet tout en cause.

La vaste majorité des développeurs ne parviennent pas à développer des applications linéaires qui fonctionnent (bugs, échec des projets...). Le parallélisme vient complexifier tout ça et rend les applications presque impossible à tester.

Auparavant lorsqu'on demandait à un développeur d'améliorer les performances d'une application, il lui suffisait de répondre "Acheter un nouveau serveur dans 18 mois, il sera 2x plus rapide". Avec l'arrivée des processeurs multi-coeurs (<a href="http://www.azulsystems.com/products/compute_appliance.htm">bientôt un milier de processeurs</a>), la donne a changé. Une application linéaire est de plus en plus lente quand le nombre de processeurs augmente. La faute à la fréquence nominale qui baisse, au Garbage Collector Java qui bloque ou freine tous les processeurs, à la conception même de nos systèmes qui sont des points de contention à tous les niveaux. SGBD en premier.

<b>Alors quelles solutions ?</b>

 + Tout d'abord, le GC évolue. Il devient multi-core friendly en 1.5 et 1.6 et s'améliore encore en 1.7.
 + Hotspot aussi s'améliore. Il est capable dans bien des cas de supprimer du code de synchronisation entre les threads lorsque celui-ci est inutile.
 + Le hardware s'améliore. La mémoire étant de moins en moins chère, il devient possible de se passer complètement de base de données pour de plus en plus d'applications.
 + Reste ensuite quelques règles de base pour optimiser une application qui en a besoin : éviter tout partage, éviter les bases données, optimiser le système dans sa globalité plutôt que tenter des optimisation locales sur le code.

<b>Un dernier mot : Valtech est sponsor du JUG !</b>
