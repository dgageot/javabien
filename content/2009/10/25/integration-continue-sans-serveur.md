---
title: "Intégration Continue sans serveur (MAJ)"
date: 2009-10-25T12:00:00+01:00
tags: ["git","hudson","intégration continue"]
---

“A quoi sert un serveur d’intégration continue ?” C’est la question que nous posons chez [Tech4Quant](http://www.tech4quant.com/). Des années à prêcher pour que chaque équipe ait un serveur d’IC. Nous avions installé et utilisé Hudson dès le début du projet. Et voilà que depuis plusieurs mois, Hudson installé on ne sait plus où, échoue à chaque commit et personne ne s’en émeut.

**Comment en arriver là ?**

Le déclencheur a été le temps de maintenance du serveur Hudson. Il doit avoir en permanence toutes les briques nécessaires au build. Notre produit nécessite malheureusement que latex, R et mono soient installés, ainsi que plusieurs packages R. Il faut mettre à jour le serveur régulièrement, le rebooter parfois, faire du ménage à l’occasion.

Pourquoi passer du temps à maintenir un serveur lorsque nous pourrions nous assurer de passer tous les tests en local avant de pousser le code sur le repository partagé ?

*Décision prise: petite équipe + rigueur + build rapide = Adieu Hudson!*

**Un build de plus en plus lent**

Seulement voilà, tout build devient forcément de plus en plus long. Une minute, puis deux, puis cinq. Passer tous les tests en local devient un obstacle. Il est tentant de pousser vers un serveur d’IC sans passer les tests fonctionnels et d’attendre le verdict, un café à la main. Résultat : soit cinq minutes devant maven, soit un paquet de builds cassés.

**Course aux armements**

Devait-on mettre en place un mécanisme de commit à deux phases avec un serveur sas ? Devait-on remplacer Hudson par TeamCity qui propose aux utilisateurs d’Idea un private build distant, pré-requis au commit définitif ? Cela sonne “Course aux armements” dans ma tête. Bientôt nous aurions une ferme de build à maintenir. Vision d’horreur !

**Réduire le temps du build**

Beaucoup plus productif que d’investir dans de nouveaux serveurs, attaquons nous à la cause racine plutôt qu’à un symptôme. Tentons de réduire le temps pris par les tests. Après un peu de magie noire (un futur post), voilà notre build complet passé de plus de cinq minutes à moins de deux. On respire à nouveau. Mais la question initiale reste en suspend. Comment repousser le moment fatidique où il faudra investir dans un serveur d’IC pour absorber le temps de build invariablement croissant ?

**Git, le sauveur**

Nous utilisons git. Sa stabilité et la simplicité d’installation sont de forts atouts. L’utilisation au jour le jour est, elle, un peu ardue étant donné la médiocrité des front-ends.

En relisant [Git Magic](http://www-cs-students.stanford.edu/~blynn/gitmagic/), je me dis qu’il serait simplissime de mettre au point un build privé quasi-identique à celui de TeamCity, sans serveur distant. Dupliquons le code source de notre répertoire de travail vers un second répertoire depuis lequel on lance le build et en cas de succès on fait un commit.

Avec une autre gestion de conf, deux problème se poseraient : combien de temps prendra la duplication du projet lorsqu’il deviendra gros ? Un fois les résultats poussés depuis le répertoire dupliqué, le répertoire principal n’est pas forcément “au courant” que toutes ses modifications ont été poussées par quelqu’un d’autre.

Avec git, rien de tout ça. La première fois que l’on duplique le répertoire de travail avec ‘git clone’, git copiera tous les fichers de manière ultra-rapide (lien). Les fois suivantes, git saura mettre à jour la copie par simple delta en un claquement de doigts. Impressionnant.

Pour ce qui est de la resynchronisation du répertoire de travail, un simple ‘git pull’ se rendra compte, grâce au hash des fichiers delta, que le répertoire courant contient exactement les même fichiers et les mêmes commits que ceux qui ont été poussés sur le repository partagé. Donc rien à faire. Re-impressionnant.

**Le build privé ultime ?**

Et voilà un build privé sans maintenance, sans installation supplémentaire, indépendant de l’environnement de travail, éxécuté en une seule commande. Plus un seul build n’est en erreur dans le répository partagé et vous pouvez mettre à la poubelle votre serveur d’IC.

Car c’est bien une Intégration Continue sans serveur que l’on vient de mettre en place. Tout ce qu’un serveur d’IC sait faire en plus est à mon avis du bruit de fond.

**La recette**

Pour les plus curieux, voici le script:

```bash
#!/bin/bash
if [ 0 -eq `git remote -v | grep -c push` ]; then
	REMOTE_REPO=`git remote -v | sed 's/origin//'`
else
	REMOTE_REPO=`git remote -v | grep "(push)" | sed 's/origin//' | sed 's/(push)//'`
fi

if [ ! -z "$1" ]; then
	git add .
	git commit -a -m "$1"
fi

git pull

if [ ! -d ".privatebuild" ]; then
	git clone . .privatebuild
fi

cd .privatebuild
git clean -df
git pull

if [ -e "pom.xml" ]; then
	mvn clean install

	if [ $? -eq 0 ]; then
		echo "Publishing to: $REMOTE_REPO"
		git push $REMOTE_REPO master
	else
		echo "Unable to build"
		exit $?
	fi
fi
```
