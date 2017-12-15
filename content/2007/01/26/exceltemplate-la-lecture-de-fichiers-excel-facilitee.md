---
title: "ExcelTemplate, la lecture de fichiers Excel facilitée"
date: 2007-01-26T12:00:00+01:00
tags: ["spring","tests"]
---

<em><strong>Cet article présente un petit outil OpenSource que j'ai développé pour faciliter la lecture de jeux de test Excel dans une démarche Test Driven Requirement.</strong></em>

Le méthodes agiles préconisent de tester avant de développer. Pour ce faire, un outil comme Fitness permet d'écrire des tests utilisateur automatisés en utlisant un wiki et des tables HTML. Pour ma part, je préfère une approche basée sur des fichiers Excel®. Se pose alors la problématique de la lecture de ces fichiers.

POI-HSSF permet de lire un fichier Excel®. Toutefois le code à écrire est vite illisible et répétitif.
En m'inspirant (très) fortement des JdbcTemplate et JmsTemplate de Spring, j'ai commencé à concevoir un <a href="http://sourceforge.net/projects/excel-template">ExcelTemplate</a> capable d'encapsuler les appels à POI-HSSF, dans le but de lire des feuilles Excel®, avec un code lisible.

Voici le résultat pour convertir un onglet donné en tableau de String :

```java
ExcelTemplate reader = new ExcelTemplate ("a.xls");
String[][] lines = reader.read ("TabName");
```

Un autre exemple pour lire un liste de Map. Chaque ligne du fichier est représentée par une Map. La première ligne donne les clefs. Les autres lignes donnent les valeurs. Petite subtilité, le fichier est lu depuis le Classpath :

```java
ExcelTemplate reader = new ExcelTemplate ("a.xls",getClass());
List lineAsMaps = reader.readList ("tab");
```

Il est également possible de mapper les lignes dans des POJO, de cette façon :

```java
ExcelTemplate reader = new ExcelTemplate ("a.xls");
List beans = reader.readBeans ("tab", MyBean.class);
```

Les trois exemples précédents présentent des comportements par défaut bien pratiques. Il est toutefois possible de tout customiser par l'utilisation de classes Callback. Le code suivant lit le contenu d'un onglet avec un CellMapper  permettant de personnaliser la convertion du contenu d'une cellule en objet (par exemple pour tenir compte du style de la cellule) :

```java
String[][] lines = (String[][]) reader.read ("tab", new MyStringCellMapper(), String.class);
```

Voici un autre exemple utilisant un SheetExtractor pour personnaliser complètement la lecture du contenu d'un onglet tout en déléguant au template la compléxité du parsing de la feuille :

```java
SheetInfo sheetInfo = (SheetInfo) reader.read ("TabName", new SheetExtractor() {
public Object extractData (HSSFSheet sheet) throws IOException, DataAccessException {
return new SheetInfo (sheet.getFirstRowNum(), sheet.getLastRowNum());
}
})
```

```java
private static class SheetInfo {
public int firstRow;
public int lastRow;
```

```java
    public SheetInfo (int firstRow, int lastRow) {
this.firstRow = firstRow;
this.lastRow = lastRow;
}
}
```

Le projet est en <a href="http://sourceforge.net/projects/excel-template">OpenSource</a>. Les classes reposent sur Spring et sur POI-HSSF. Le projet est construit avec Maven2 et utilise des plug'ins comme Cobertura ou Checkstyle. Il a été développé avec une approche TDD et la couverture de tests est proche des 100%.

Il me reste à écrire la documentation. Un volontaire ?
