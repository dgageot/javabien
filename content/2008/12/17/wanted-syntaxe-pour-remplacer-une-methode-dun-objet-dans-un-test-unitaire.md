---
title: "Wanted : syntaxe pour remplacer une méthode d'un objet dans un test unitaire"
date: 2008-12-17T12:00:00+01:00
tags: ["java","mockito"]
---

J'utilise le framework <a href="http://code.google.com/p/mockito/">Mockito</a> depuis quelques mois pour simplifier l'écriture de mocks dans mes tests unitaires.
Là où <a href="http://www.easymock.org/">EasyMock</a> ne m'a jamais convaincu, Mockito présente une syntaxe à la fois simple et puissante. Par contre, il m'arrive de vouloir remplacer une méthode bien précise d'un objet soumis au test et là, Mockito ne m'aide pas.

Voilà ce que je suis obligé d'écrire :

```java
final FileTemplate mockFileTemplate = new FileTemplate();

CopyFileRule rule = new CopyFileRule("src.txt", "dest.txt") {
	@Override
	protected FileTemplate createFileTemplate() {
		return mockFileTemplate;
	}
};
```

Voilà la syntaxe que j'aimerais avoir :

```java
CopyFileRule rule = intercept(new CopyFileRule("src.txt", "dest.txt"));

when(rule.createFileTemplate()).thenReturn(new FileTemplate());
```

Connaissez-vous un outil qui permettrait de faire ça ?
