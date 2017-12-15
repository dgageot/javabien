title: "XPDays, la magie eXtreme Programming"
date: 2006-04-11T12:00:00+01:00
tags: ["xp"]
---

**Après Londres, Bruxelles, Rotterdam et Karslruhe, la conférence "XP Day" a désormais sa version française. XP Day France s'adressait aux professionnels du logiciel, quel que soit leur niveau de connaissance de l'Extreme Programming.**

**Retours d’expérience sur eXtreme Programming**

Ce séminaire a été l’occasion pour les nombreux intervenants de présenter leurs **expériences** sur les méthodes agiles et en particulier sur XP. Ces retours étaient d’autant plus intéressants que certains intervenants pratiquent XP sur leurs projets depuis près de huit ans.

Un aspect notable est la capacité d’XP à **s’adapter à tout type de client** : éditeur, télécom, banque, startup, société industrielle,… Il s’avère aussi que dans tous les cas exposés, l’utilisation de méthodes agiles est plutôt une réussite. En particulier, XP excelle sur les projets de migration technologique ; le pair programming permet dans ce contexte d’associer un développeur connaissant le métier à un autre compétent en nouvelles technologies. Dans d’autres contextes, il ressort que la mise en place du pair programming (binomage dans la langue de Molière), passe difficilement auprès des top managers.

Un autre point commun à plusieurs projets : XP est souvent mis en place en premier lieu sur des projets plantés, stagnant à cause du trop grand nombre d’anomalies. La première action est alors de mettre en place une batterie    de tests avant d’effectuer du refactoring. **Comme par magie, les projets de relèvent alors lentement mais surement.**

**Automatisation des tests fonctionnels**

Lors d’une présentation, Régis Médina (DesignUp) a insisté sur l’absolue nécessité de mettre en place des tests fonctionnels automatisés (avec JUnit), en grande quantité. Lors une séance interactive, il a démontré comment appliquer la philosophie XP : garder des tests simples et remanier ces tests au moins autant que le code.

Deux choses extrêmement intéressantes dans cette démonstration :

1) D’une part, elle permet de s’apercevoir que la théorie n’a rien de nouveau mais que la bonne **maitrise d’un outil de refactoring** (en l’occurrence IDEAJ) a un **effet un peu magique** sur les  développeurs peu habitués au remaniement.

2) D’autre part, il est intéressant de noter que le refactoring des tests fait émerger des concepts au même titre que le refactoring du code fait émerger une architecture. Plus on simplifie l’écriture de nouveaux tests, plus on se concentre sur les données en entrée et en sortie du système plutôt que sur le déroulement des actions de l’utilisateur.

**UISpec4j**

Autre bonne surprise : la présentation de l’outil UiSpec4j pour tester les applications Swing. Cet outil est un projet Open Source qui a vu le jour au cours d’un développement XP. Il semble aller assez loin dans la simplification de tests fonctionnels d’applications Swing. Par exemple, pour tester le contenu d’une JTable, le code suivant est suffisant :

```java
public void testContacts() {
  Table noms = getMainWindow().getTable();

  assertTrue (contacts.contentEquals (new Object[][] {
  {"John", "12", Boolean.FALSE},
  {"Sylvia", "43", Boolean.TRUE},
  {"Bill", "31", Boolean.FALSE}}));
}
```

Admirez comment ce code accède à la JTable d’un panneau : un simple getTable() suffit pour les interfaces avec une seule table visible. De plus, la méthode contentEquals ne teste pas le modèle (le M de MVC) mais bien la vue, le Renderer dans le cas de Swing. Le tout en mode headless, grâce à un look&feel spécifique qui joue l’intercepteur. **Un rien magique, encore une fois**.
