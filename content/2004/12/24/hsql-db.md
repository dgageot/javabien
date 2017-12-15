---
title: "HSQL DB"
date: 2004-12-24T12:00:00+01:00
tags: ["database","java","tests"]
---

Dans le cadre du développement du logiciel ADE, chez <a href="http://www.adesoft.com/">ADESOFTware</a>, j'ai pu mettre en place une base de données relationnelle <a href="http://hsqldb.sourceforge.net/">HSQLDB</a>. Ce système remplace avantageusement MSAccess pour une installation de test ou un maquettage. Tout comme Access, aucune installation n'est nécessaire, seul un fichier contenant le script de création des tables est requis. Contrairement à Access, les performances sont étonnantes pour des bases de taille raisonnable.

Cela est dù au mode de fonctionnement de HSQLDB. Il s'agit plus d'une base de données mémoire que d'un vraie base avec fichiers. En fonctionnement standard, les requêtes sont stockées dans un fichier journal et exécutées en mémoire. C'est ce journal qui sert de persitence. Lors de la première connexion à la base, le fichier est réexécuté en mémoire pour restaurer l'état avant déconnexion. Des mécanismes avancés permettent d'organiser certaines tables dans des caches stockés sur fichiers.

Cela me fait penser qu'en stockant toutes les requêtes avec leur date d'éxécution, et en permettant de rejouer le journal jusqu'à une certaine date, on pourrait récupérer une image de la base à n'importe quelle date.
