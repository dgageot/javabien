---
title: "Meilleur de Dev de France 2013"
date: 2013-10-11T12:00:00+01:00
tags: []
---

Ce soir, j'étais à l'école 42 pour le concours du Meilleur Dev de France. En rentrant chez moi j'ai cherché une image qui pouvait exprimer mon amertume suite à cet événement. Je suis tombé par hasard sur ce <a href="https://twitter.com/history_pics/status/388422652014374913">tweet</a> contenant une image du Titanic et de son sister ship l'Olympic :

![Titanic et Olympic](/images/BWP0WAHIYAAoncj.jpg#center)

Le mdf2013 est un Titanic, ambitieux mais trop pompeux, qui a sombré et je lui souhaite une prochaine édition plus réussie comme le fut la carrière de l'Olympic.

<strong>L'idée de départ</strong>

Il faut dire que j'étais tout excité à l'idée de ce concours. Un concours pour des développeurs. L'idée me tient évidemment à coeur puisque j'organise le modeste concours <a href="http://www.code-story.net/blog/">CodeStory</a> depuis trois ans. Modeste mais tout de même <a href="http://status.code-story.net/">130 participants</a> l'an dernier.

L'organisation semblait ambitieuse et allait dans le bon sens. Les développeurs doivent être plus valorisés ! Le fait que le concours soit payant ne m'a pas vraiment gêné. Mais cela a déclenché pas mal de réactions négative depuis le mois d'aout. Les tarifs avait d'ailleurs été revus à la baisse de manière très significative. (Et je suis toujours en attente de mon remboursement de la différence...)

Bon en tout cas ce soir à 18h30 j'étais chaud bouillant devant l'école 42. Prêt à en découdre, à m'amuser et à apprendre de l'organisation d'un tel événement.

<strong>L'installation</strong>

L'organisation pour rentrer et s'installer est fluide. Pas de soucis, tout est bien dimensionné. Les salles info sont impressionnantes avec tous ces iMac ! Du beau matériel. Plein de temps pour installer mon IntelliJ et mes <a href="https://github.com/dgageot/dotfiles">dotfiles</a> et rencontrer quelques têtes connues. Tout fonctionne bien. Je suis prêt !

<strong>Le lancement</strong>

Un peu en retard, le concours est lancé ! Il faudra soumettre des bouts de code dans une interface web qui nous donne du feedback sur l'exécution de notre code. Il y aura 11 questions. Et, chouette nouvelle, on aura des cadeaux à la fin même si on n'est pas premier. On rentrera tous en "taxi" Uber et on aura un bon cadeau pour un site de rencontre. N'étant pas célibataire, je me réjouis surtout de rentrer au chaud dans une Uber. Mais nous verrons pas la suite que c'était en fait un joli mensonge.

<strong>Première étape</strong>

La première question est tombée. Il faut écrire le code qui "merge" des Iterators de valeurs triées en un Iterator de valeurs triées. Le temps de comprendre d'énoncé et de réaliser : "Facile, j'ai déjà fais ça dans un ancien job". Seul ombre au tableau, j'ai perdu 5 minutes à cause d'une boulette de l'orga. Peu importe mon code, le moteur de vérification ne fonctionne pas car le superviseur a fait une manipulation de dernière minute qui oblige certains participants à se reconnecter. Quelques précieuses minutes perdues mais on garde la moral !

<strong>Deuxiéme étape</strong>

Une variante du FizzBuzz. Le Buzz. Les nombres de 1 à 100 sont remplacés par "Buzz" s'ils sont multiples de n ou de p. Il faut deviner n et p. Un peu de mal à comprendre au début mais la solution est finalement très simple.

D'après ce que j'ai pu voir en me baladant dans le salle en fin de concours, ces deux premiers exercices partagent déjà la population en deux. La grande majorité qui n'arrive pas à résoudre ces deux défis et les autres.

<strong>Troisième étape</strong>

... Rien. La question n'arrive pas. On se reconnecte. Toujours rien. Quelques participants ont le même problème. L'orga est à la rue. Gros problème technique qui ne touche que certains joueurs. Communication avec les participants quasi inexistante. Résultat des courses. Au moins 30 minutes de perdues et certains joueurs sont déjà à la question 5, eux. Il va falloir carburer pour rattraper ce retard ! Mais le moral n'est plus là.

Enfin, la situation se règle. La troisième question est là. (Elle ne pas m'a pas marqué, c'est la seule dont j'ai oublié l'énoncé...) Les questions vont se succéder bon an, mal an avec quelques minutes de bug à l'enchainement de chaque question. Il faut de déconnecter et se reconnecter plusieurs fois. Se lever pour le signaler à l'orga. C'est vraiment désagréable. Ca casse le fameux flow dans lequel on est à chaque question. Mais bon, à chaque question ma place s'améliore. 29ème 20ème puis 10ème. Je regagne en concentration. Enfin 4ème sur la dernière question ! 4ème, la place pourrie par excellence. Seul les trois premiers auront l'honneur d'être annoncés en public. En plus ce classement est à vérifier. Vu les erreurs techniques à tous les niveaux, je ne suis pas certain qu'il soit juste. On devrait avoir un classement officiel avec les logins dans les jours qui viennent. Ca permettra en plus de vérifier le nombre de participants. 500 selon les orga. 270 selon la police...

<strong>Le point sur la participation</strong>

Difficile en effet de savoir combien de participants ont réellement été mobilisés. Tous les orga. un peu commerciaux, vendeurs à la criée, parlent de 500. Les orga plus techniques parlent des contraintes posées par 270 participants. Ca fait une réelle différence en termes de succès. Les couacs sur le tarif et la mauvaise pub sur les blogs et twitter ont eu leur effet. Mais l'orga a eu la bonne idée de noyer les développeurs parmi les invités. Une autre bonne idée a été de ne pas faire payer une bonne partie de participants. Enfin bonne idée pour les heureux élus, pas pour ceux qui comme moi ont payé.

<strong>Revenons aux questions</strong>

Dans le désordre, les questions étaient les suivantes :

Coder une logique de pesage pour deviner parmi 8 billes lesquelles 4 sont légères et lesquelles 4 sont lourdes. Là j'ai utilisé de la super super brute force. Je pèse deux billes aléatoires contre deux autres billes aléatoires, en évitant les doublons. Le groupe le plus lourd marque un point, le plus léger perd un point. Au bout de 50000 pesées, ça donne deux groupes. Les billes légères ont un petit score, les billes lourdes un gros score. Pas très fier de cette solution là...

Détecter si l'on passe deux fois sur le même segment quand on relie des points entre eux. ABCDEF c'est bon. Mais pas ABCBA car on passe deux fois par le segment AB. Facile, on découpe le chemin en segments. Chaque segment est ordonné par ordre alpha. Et on cherche les doublons avec un Set<String>.

Dépiler des Tasks par ordre de priorité. Facile avec une PriorityQueue et le Comparator<Task> qui va bien.

Sortir le listing d'un répertoire, en xml. Passé la recherche de l'api DocumentBuilder sur Google, il suffit d'un parcours récursif en profondeur.

<strong>La fin</strong>

La fin du concours est annoncée en peu en catimini. Le responsable de l'infrastructure des questionnaire est vraiment désolé de la gène occasionnée. Les participants que j'ai pu rencontrer lors de nos phases de blocage sont un peu dégoutés comme moi. Ils avaient aussi réussi à bien grignoter leur retard et une demi heure de plus ou de moins, c'est facilement deux questions de handicap. Le premier a répondu à huit questions, nous à six ou sept.

<strong>Les gagnants</strong>

L'annonce des gagnants se déroule sans vraie passion à mon gout. Beaucoup d'auto congratulation. Pas vraiment de passion ni d'histoire de développeur. On voudrait savoir comment ils ont résolu les énigmes. Ce qu'ils ont ressenti pendant le concours, leurs stratégies. Mais personne ne semble intéressé. Ou sont les passé les devs ??

En tout les cas, bravo aux 3 premiers, ils ont su avancer malgré les soucis techniques. Ou bien ils n'en ont pas rencontré. On ne saura jamais. Ca cause un peu d'aigreur chez moi. Quand je participe c'est à fond de mes capacités. Ici, nous avons été nombreux à nous sentir volés. Au moins nous avons pu parler entre développeurs au chômage technique. L'ambiance était très bonne de ce coté là.

<strong>L'heure de rentrer</strong>

Bon, je me dis que tout n'est pas perdu. Je me renseigne pour prendre un Uber comme promis par les orgas. Et non ! Il faut être nouvel utilisateur pour avoir droit aux 25 euros de crédit. Moi je n'ai pas le droit au faux cadeau. Pourtant j'ai payé mon entrée moi contrairement à beaucoup de participants. Gros gros fail de Uber. Et leur réaction sur twitter est du même accabi. "Et non, je n'ai pas le droit au cadeau mais je peux partager mon code de parrainage pour gagner 10 euros". Me voici donc à minuit rentrant en bon vieux taxi.

<strong>En résumé. Une bonne intention. Des gros problèmes techniques pas trop graves pour un concours gratuit mais inacceptables pour un concours payant. En cadeau, un bloc notes et une lampe torche porte clef qui ne fonctionne pas.</strong>

Et je me dis qu'il y a vraiment de boulot pour la prochaine édition ! Une proposition. Mettre encore plus en valeur les développeurs et réduire le bruit marketing.

<strong>Vive les développeurs !</strong>
