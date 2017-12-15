---
title: "Une bonne couverture de tests doit s'accompagner d'une fragilité des tests"
date: 2008-04-28T12:00:00+01:00
tags: ["tests"]
---

Une bonne couverture de code par les tests est primordiale. En même temps, un taux de couverture élevé ne signifie pas grand chose. ce que je vais appeler <em>la fragilité des tests</em> est un élément très important.

Par exemple : Ca n'est pas parcequ'un test <strong>couvre</strong> une partie de mon code que cette partie est <strong>testée</strong>. Imaginez un test sans <em>assert</em>. Ce test participe à la couverture des tests mais pas à leur qualité. En effet, s'il n'y a pas d'<em>assert</em>, le test a toutes les chances de toujours passer. Un test pour être efficace doit être plutôt <em>fragile</em>. C'est à dire qu'il doit casser à la moindre modification du fonctionnel.

Certains outils comme <a href="http://jester.sourceforge.net/ ">jester.sourceforge.net</a> cherchent à mettre en évidence les tests trop résistants au changement. L'idée est que si je touche le code de façon intelligente, au moins un des tests devrait casser.

Une autre méthode plus statique serait de pondérer la couverture du code par les tests en fonction du nombre d'assert par test et de leur type : un assert.isNotNull() est moins fragile qu'un assert.equals(). Il participe donc moins bien à l'effort de test.

Connaissez-vous des outils de ce type ?
