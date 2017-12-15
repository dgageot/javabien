---
title: "Hello jTDC et SQL Server Express"
date: 2004-12-23T12:00:00+01:00
tags: ["database","java"]
---

Hello <a href="http://jtds.sourceforge.net/">jTDS</a> est un excellent driver JDBC pour <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=62B348BB-0458-4203-BB03-8BE49E16E6CD&displaylang=en">SQL Server</a>. Il s'agit d'un driver 100% Java (donc de type 4) compatible avec JDBC 3.0. Ce qui est particulièrement remarquable, c'est le gain de vitesse visible que l'on obtient par rapport au driver ODBC par défaut. Ce gain est d'autant plus visible que l'on utilise la version 2000 de SQL server car la dernière version de jTDS apporte le support du protocole de communication TDS en version 8.0.

Couplé à <a href="http://www.microsoft.com/downloads/details.aspx?FamilyID=413744D1-A0BC-479F-BAFA-E4B278EB9147&displaylang=en">MSDE</a>, on obtient un ensemble homogène et gratuit aux performances excellentes pour des applications professionnelles. Je préfère d'ailleurs cette solution à un <a href="http://www.mysql.com/">MySql</a>. L'outil graphique de gestion de la base qui accompagnera SQL Server 2005 Express sera sans aucun doute un atout supplémentaire.
