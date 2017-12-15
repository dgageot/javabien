---
title: "Editique et automatisation des tests"
date: 2007-02-26T12:00:00+01:00
tags: ["coaching","scrum","tests"]
---

Je viens de démarrer un nouveau projet en tant que Scrum Master. Je me trouve au sein d'une équipe éditique. Nous devons produire une batteries de documents destinés à des clients (courriers, contrats, ...). La qualité des documents est notre préoccupation première.

Pour valider le contenu et la forme de nos documetns, Scrum va nous permettre de vite avoir du feedback. Par contre, il existe de nombreuses règles à respecter pour qu'un document soit complet et satisfaisant. Par exemple, nous sommes limités à une liste de polices et à certaines couleurs. Nous devons vérifier que les blocs de texte ne se chevauchent pas dans des cas limites. Les marques de pliage et les adresses postales doivent être positionnées très précisément... Dans ce domaine, il n'est pas certain qu'un oeil humain puisse nous aider. Plus le nombre de règles est important, plus difficile il sera de valider un document.

Mes réflexes de développeur Java me poussent à chercher des outils de tests automatisés. Un peu comme un checkstyle permet de vérifier le respect de quelques normes de codage, il faudrait un outil capable de décortiquer un document pdf et à même de vérifier certaines règles communes à tous les documents.

Mes recherches sur Google n'ont rien donné pour l'instant. Il semble exister un marché pour les outils vérifiant si un pdf respecte les normes d'accessibilité mais rien pour le domaine éditique pur. On doit se contenter d'un outil qui prend un fichier xml en entrée, lance la génération de pdf et compare avec un document cible. Cela permet juste d'évacuer la plupart des régressions.

Si l'on parvient à lire le contenu d'un pdf en Java (peut-être avec iText), il est théoriquement possible de coder certaines de ces règles, mais cela reste complexe.

Avez-vous des expériences similaires ou de idées à me soumettre ?
