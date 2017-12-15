---
title: "Maven2 : des pom pourris ?"
date: 2006-04-10T12:00:00+01:00
tags: ["maven"]
---

<strong>Après deux mois d'utilisation de Maven2 sur un projet, je me pose des questions quant à la plus value de Maven2 par rapport à Maven. N'est il pas plutôt question d'une moins value ?</strong>

L'argument majeur de Maven2 par rapport à Maven est l'ajout de dépendances transitives.

Dans le contexte d'une maquette, cela fonctionne très bien. Maven2 est capable de télécharger les dépendances de mes dépendances.

Dans le cas d'un projet grandeur nature, on est vite confronté à la qualité inégale des pom disponibles sur les repository publiques. Certains ne sont pas correctements formés, d'autres ne sont pas valides, enfin certains ne déclarent pas toutes leurs dépendances.

La solution généralement admise est de patcher à la main les pom dans un repository privé. Le problème survient lorsque l'on veut emporter le projet ailleurs (chez soi par exemple). Il faut à nouveau patcher tous les pom.

Une solution intermédiaire serait de pouvoir redéfinir des pom de dépendance dans le pom de notre projet. Ainsi la description des patch voyage avec le projet.
