# Gestion du projet {#sec:gestion}

Ce chapitre traite de la relation avec la BEES coop et du déroulement du
projet.


## Réunion de présentation d'avancement

Le travail de fin d'étude, en plus du développement de l'application
CoopDesk, inclut aussi la gestion de la relation avec le client
BEES coop. Au sein de la BEES coop, une équipe s'est constituée pour
suivre le projet. Cette équipe regroupe principalement le bureau des
membres qui s'occupe de la gestion des membres et du travail au sein de
la coopérative, mais aussi un permanent et un membre du comité
« communication ».

Une première réunion s'est tenue le mercredi 20 septembre 2017.
Cette réunion a permis de définir les besoins et de prioriser ceux-ci.
Il s'en est suivi la phase d'apprentissage et les premières réalisations
prioritaires qui ont été mises en production à la fin du stage,
c'est-à-dire à la Toussaint 2017.

Une fois le stage terminé, un plan d'avancement a été établi pour la
suite des développements et un planning de réunion a été mis sur pied.
La proposition était de rencontrer l'équipe de la BEES coop, afin de
faire le point sur l'avancement, aux moments suivants :

- avant les fêtes de fin d'année ;
- mi-février ;
- fin mars ;
- fin avril.

La première réunion d'avancement a eu lieu le mardi 19 décembre 2017
conformément au planning. Lors de cette réunion, la version 1 de
l'application CoopShift a été présentée. L'application CoopShift a donné
un premier aperçu concret du potentiel de CoopDesk. De nouveaux besoins
sont apparus et des bogues ont été trouvés (voir
chapitre \vref{sec:coopshift}) notamment le besoin d'afficher des textes
d'aide concernant les statuts du travailleur à la BEES coop. Le bureau
des membres souhaitait lancer l'application fin janvier.

Le 21 janvier 2018 la version 1 de CoopShift a bien évolué. Tous les
nouveaux besoins sont comblés. Il reste un bogue dans l'affichage des
dates et des heures et il manque les textes d'aide qui doivent être
fournis par la BEES coop. Malheureusement, le bureau des membres était
débordé et ne sait pas fournir les textes. La réunion prévue pour
mi-février dans le planning n'aura pas lieu. L'application CoopShift a
donc été mise de côté afin de se concentrer sur la conception et le
développement de CoopInfoPerso.

Ayant dû traiter d'autres sujets plus urgents pendant les mois de
janvier et février, les acteurs de la BEES coop ont demandé un état des
lieux afin de pouvoir reprendre le train en marche. Ils ont donc reçu de
ma part, le 19 février 2018, un petit récapitulatif de ce qui avait été
fait et des actions qu'ils devaient prendre afin de faire avancer
l'application CoopShift.  La finalisation de CoopShift a pu se faire à
partir de mi-mars. Entretemps, les autres applications formant CoopDesk
ont bien avancé, sauf CoopReceipt qui avait une faible priorité.

Le mercredi 4 avril 2018 s'est tenu une réunion avec le bureau des
membres pour présenter la version 2 de CoopShift qui incluait tous les
nouveaux besoins exprimés lors de la réunion de décembre, y compris les
textes d'aide reçus mi-mars. De plus, les applications CoopInfoPerso et
CoopDocument ont été présentées. CoopDocument est fonctionnelle, mais
l'interface d'administration doit être légèrement améliorée afin d'être
similaire aux autres applications. CoopInfoPerso est très convaincante,
mais un bogue quant aux téléchargements des PDF a été remarqué sur le
serveur de test. L'application CoopShift a été relue par d'autres
développeurs, puis mise en production début mai.

La dernière réunion prévue dans le planning se déroulera finalement en
juin. Le mois de mai a permis de résoudre tous les bogues blocants qui
restaient. Les autres applications composant CoopDesk pourront être
présentées et mises en production après leur validation lors de cette
réunion.


## Gestion des serveurs et processus de mise en production

Tout au long du développement, il a fallu gérer la mise en place sur le
serveur de test et la mise en place sur le serveur de production. Le
serveur de test est une réplication de la base de données du serveur de
production à un instant donné. Il faut de temps en temps le mettre à
niveau par rapport au serveur de production en important les données
provenant de ce dernier. La seule contrainte, lors de la mise en place
de nouveaux codes sur le serveur de test, est de s'assurer que personne
n'est en train de l'utiliser pour faire des tests. Quant au serveur de
production, c'est beaucoup plus délicat. Les coupures d'Odoo ne peuvent
être faites que le dimanche après-midi lorsque le magasin est fermé. En
cas de problème lors de la mise en production, il est encore possible
d'y travailler le lundi matin. Cependant, il faut absolument qu'Odoo
soit opérationnel pour la réouverture du magasin le lundi midi.

Afin d'effectuer un suivi des tâches, c'est l'outil de gestion de
projet d'Odoo qui est utilisé. Chaque tâche passe par les états
suivants:

1. **Spécification** : Cette étape correspond à la définition des
   besoins fonctionnels, ce que doit permettre le futur développement.
1. **Spécification technique** : Cette étape correspond à la description
   de la réalisation du développement d'un point de vue technique.
1. **Correction nécessaire** : Cette étape intervient lorsque le ticket
   est déjà passé par la case développement mais n'a pas passé les
   tests.
1. **Développement**
1. **Validation technique** : Cette étape correspond aux tests qui
   valident si le développement correspond bien aux fonctionnalités
   attendues.
1. **Revue technique** : Cette étape correspond à une relecture et une
   correction du code écrit par un pair.
1. **Validation utilisateur** : L'utilisateur teste le développement
   dans l'environnement de test.
1. **Déployé** : Cette étape correspond à la mise en production du
   développement.

Un autre outil est utilisé, notamment lors de l'étape de validation
technique, afin de pouvoir tester les développements : le *runbot*.
C'est un logiciel qu'Odoo met à disposition, qui est interfacé à Github
et permet de créer une instance d'Odoo pour chaque branche disponible
sur Github. Cependant quand le travail demande beaucoup de données
particulières, le travail est alors placé sur le serveur de test. Cela
évite de devoir réencoder toute une série de données lors de chaque
test.
