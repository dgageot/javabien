---
title: "Troll Java/Scala quand tu nous tiens!"
date: 2012-08-28T12:00:00+01:00
tags: ["humeur","java","scala","troll"]
---

Ca trolle sévère sur <a href="https://groups.google.com/forum/#!topic/lescastcodeurs/dNyBiy_QjM8">la mailing liste de Cast Codeurs</a> concernant le <a href="http://scalaz.github.com/scalaz/scalaz-2.9.1-6.0.4/doc.sxr/scalaz/Category.scala.html">code de Scalaz</a>.

<a href="http://en.wikipedia.org/wiki/Troll_(Internet)"><img alt="Troll" src="http://upload.wikimedia.org/wikipedia/en/thumb/7/78/Trollface.svg/200px-Trollface.svg.png" title="Troll" class="aligncenter" width="200" height="159" /></a>

Qu'il est difficile de comparer, Java, un langage conçu pour aider les développeurs à évoluer dans un monde pas trop dangereux pour lui-même et Scala, un langage conçu pour donner les pleins pouvoirs au développeur quitte à ce que l'arme lui pète entre les mains.

Cela est d'autant plus difficile que paradoxalement Java n'a pas atteint son objectif de protection du développeur (cf. <a href="http://www.amazon.fr/JavaTM-Puzzlers-Pitfalls-Corner-ebook/dp/B001U5VJVS/ref=sr_1_3?ie=UTF8&qid=1346172866&sr=8-3">Java Puzzlers</a>) et Scala offre aussi une protection par son système de typage.

<strong>Et la lisibilité du code ?</strong>

La lisibilité des deux langages entre aussi en jeu dans la comparaison. Chaque langage porte ses contradictions:

 + Java a une syntaxe redondante, lourde mais rassurante pour le lecteur.
 + Scala a une syntaxe ultra ramassée et un système de typage très verbeux pour qui cherche le maximum de protection à la compilation.

<strong>OO versus FP</strong>

Et puis il y a la programmation fonctionnelle qui fait grincer les dents. Ceux qui ont pratiqué aiment, les autres n'arrivent souvent pas à lire le code, faute d'habitude. Pour shématiser, on passe du mode 'une opération par ligne' facile à lire au one-liner 'un concept par ligne' rapidement trop ramassé. Ceci étant dit, j'aime la programmation fonctionnelle. Que de contradictions.

<strong>L'effet DSL</strong>

Enfin, la mode des DSLs obscurcit elle aussi le débat Java/Scala. Je m'explique:

 + En Java, on n'écrit pas de DSL ou alors ultra rudimentaire. Mockito ou FestAssert par exemple.
 + En Scala (ou Groovy ou Lisp), on écrit des DSL un peu partout.

Or, le code derrière un DSL est toujours plus difficile à lire que le code utilisant le dit DSL. Peu importe l'outillage ou le langage, un "interpréteur" est plus abstrait, plus exhaustif, plus précis que le code utilisateur.
Tout ca pour dire que comparer la lisibilité d'un code métier Java avec du code implémentant un DSL en Scala est un non sens. Allez lire le code derrière Mockito et riez à l'idée du peu de code nécessaire pour coder ça en Lisp (et sans doute en Scala).

<strong>L'effet humain</strong>

Bien sur il est humainement possible d'écrire du code métier Java moins expressif qu'une implémentation de DSL en Scala. Ca aussi ça brouille les cartes !

<strong>Les lenteurs de l'âge</strong>

Personnellement, je suis très bloqué dans mon adoption de Scala par la lenteur de compilation. Pourtant javac 1.0 était beaucoup beaucoup plus lent et je me suis jeté dessus. Trop vieux pour ce genre de conneries...

Sur ce, je retourne faire du Ruby!
