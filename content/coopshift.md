# CoopShift : la gestion des *shifts* {#sec:coopshift}

Ce chapitre traite de l'application fournissant une interface pour que
le coopérateur puisse gérer son travail au sein du supermarché
coopératif.


## Le besoin

La BEES coop fonctionne sur un modèle particulier : les coopérateurs qui
veulent faire leurs courses dans le magasin doivent aussi y travailler
bénévolement 3 heures toutes les 4 semaines. Une série de règles
organisent le travail des coopérateurs.

Le travail est organisé par semaine : la semaine A, la semaine B, la
semaine C et la semaine D. Ces quatre semaines se suivent dans l'ordre
et périodiquement, c'est-à-dire, qu'une fois la semaine D terminée, on
revient à la semaine A comme illustré dans la
figure \vref{fig:shift-timeline}. Chaque semaine est découpée en
créneaux. Un créneau représente une tranche horaire pendant laquelle un
certain travail doit être réalisé par un ou plusieurs travailleurs. Par
exemple, comme sur la figure \vref{fig:shift-planning}, le jeudi de la
semaine B de 12h à 15h, il y a un créneau pour le travail en magasin.
Il peut y avoir plusieurs créneaux en même temps pour autant que les
tâches à effectuer soient différentes. Par exemple, un créneau en
magasin et un créneau administratif.

Les *shifts* représentent le travail d'un coopérateur un jour donné pour
un créneau donné. Par exemple, comme montré dans la
figure \vref{fig:shift-template}, le *shift* de Sophie, le mercredi 3
janvier 2018 de 12h à 15h, dans le magasin, est lié au créneau du
mercredi de 12h à 15h de la semaine A de la
figure \vref{fig:shift-planning}. Plusieurs *shifts* existent pour le
même créneau à la même date, car plusieurs travailleurs sont souvent
nécessaires pour réaliser le travail prévu par le créneau. Chaque
*shift* assigné à un même créneau est donc identique si ce n'est le
travailleur qui le réalise.

![Les semaines se succèdent avec la date des lundis de chaque
semaine.](images/shift-timeline.png){#fig:shift-timeline width=100%}

![Simplification d'un ensemble de créneaux qui s'étalent sur deux
semaines différentes. Les créneaux ont des tâches
différentes.](images/shift-planning.png){#fig:shift-planning width=50%}

![Un exemple de *shifts* et les créneaux auxquels ils sont liés. Les
*shifts* sont fixés à une date précise et attribués à une personne
précise.](images/shift-template.png){#fig:shift-template
width=60%}

Il existe trois régimes de travail différents : régulier *(regular)*,
volant *(irregular)*, exempté *(exempted)*.  Chaque travailleur doit
être inscrit à un régime de travail. Le travailleur inscrit en régime
régulier choisit de faire ses *shifts* de manière régulière,
c'est-à-dire au même créneau toutes les 4 semaines. Ce travailleur est
alors automatiquement inscrit à un *shift* pendant ce créneau toutes les
4 semaines. Le travailleur inscrit en régime volant choisit librement le
*shift* auquel il s'inscrit. Il doit cependant veiller à faire au moins
l'équivalent d'un *shift* toutes les 4 semaines.  Cependant, il lui est
possible d'anticiper des *shifts* pour prévoir une période
d'indisponibilité future. Enfin le travailleur inscrit en régime exempté
est simplement dispensé de faire des *shifts* dans le supermarché. C'est
le cas notamment des personnes âgées, des femmes enceintes, etc.

Chaque travailleur se voit attribuer un statut. Les principaux sont : à
jour *(up to date)*, en alerte *(alert)*, désincrit *(unsubscribed)*. Le
statut d'un travailleur est influencé notamment par son compteur de
*shift* qui comptabilise les présences du travailleur aux *shifts*
auxquels il s'est inscrit. C'est ce statut qui conditionne le droit de
faire ses courses dans le supermarché.

L'inscription des travailleurs volants à un *shift* se fait actuellement
par courriel ou par formulaire papier. Chaque demande d'inscription est
traitée une par une. CoopShift doit permettre d'automatiser ce
processus.

Aujourd'hui, le travailleur doit tenir lui-même la comptabilité des
*shifts* qu'il a prestés dans le supermarché. Celle-ci est complètement
déconnectée du calcul fait par le système de gestion des *shifts*.
CoopShift doit fournir un moyen pour les travailleurs de consulter
l'état de leur travail dans le supermarché.


### Le besoin initial

CoopShift doit fournir une interface conviviale dans le but de permettre
aux travailleurs, de manière personnelle et sécurisée :

- de consulter leur régime de travail ;
- d'avoir accès aux dates de leurs prochains *shifts* ;
- de consulter leur statut et leurs compteurs de *shifts* ;
- de consulter les créneaux disponibles (utile pour les
  travailleurs inscrits en régime régulier) ;
- de consulter la liste des *shifts* où il reste des places disponibles
  (utile pour les travailleurs inscrits en régime volants) ;
- de s'inscrire à un *shift* (uniquement pour les travailleurs inscrits
  en régime volant).


### Le besoin final

Tout au long du développement et de l'utilisation de la première version
de CoopShift, le besoin de la BEES coop s'est précisé et a évolué. À la
liste précédente s'ajoute :

- la consultation des *shifts* précédents avec leurs statuts (présent,
  absent, etc.) ;
- l'affichage de la date à laquelle le travailleur change de statut de
  « à jour » à « en alerte » (uniquement pour les travailleurs inscrits
  en régime volant) ;
- l'affichage des dates de début et de fin de congé ;
- l'affichage de texte explicatif sur la signification de chaque statut
  et de l'utilisation de CoopShift.


## Conception

L'application CoopShift est constituée d'un seul module nommé
*beesdoo_website_shift* qui se base sur le module *beesdoo_shift*. Elle
se base sur le patron de conception MVC (modèle-vue-contrôleur). Le
module *beesdoo_shift* contient entre autre la définition des modèles.
Les créneaux, les *shifts* et le statut des coopérateurs y sont
également définis.  *beesdoo_website_shift* se concentre sur l'aspect
interface *website* et contrôleur. L'application n'est composée que d'un
seul module à l'image de *beesdoo_shift* qui regroupe la gestion du
travail des coopérateurs dans un seul module.

Le module apporte une page web, accessible via l'URL \url{/my/shift},
qui affiche trois vues différentes en fonction du régime de travail de
l'utilisateur connecté.  Cependant, une bonne partie de ses vues a des
parties en commun. C'est pourquoi, il a été choisi de les segmenter en
vues élémentaires s'occupant chacune de l'affichage d'une information en
particulier. Par après, ces vues élémentaires sont mises ensemble pour
former les trois vues principales. La
figure \vref{fig:shift-template-hierarchy} donne un exemple du lien
entre quelques vues élémentaires et quelques vues principales. Cette
manière de faire évite une duplication inutile de code et rend plus
facile la recherche et la résolution de bogues mais aussi les
modifications futures.

![Les vues principales appellent les vues élémentaires pour les parties
qu'elles ont en commun avec d'autres vues. Les appels des vues
principales sont représentés par des
flèches.](images/shift-template-hierarchy.png){#fig:shift-template-hierarchy
width=100%}

Comme on peut le voir dans les figures \vref{fig:shift-controller} et
\vref{fig:shift-template-hierarchy}, à chaque vue, élémentaire ou
principale, correspond une méthode dans le contrôleur. Les méthodes pour
les vues principales font appel aux méthodes des vues élémentaires comme
on peut le voir dans la figure \vref{fig:shift-activity} qui illustre le
déroulement de la génération des pages. La méthode *my_shift()* est
toujours la première à être appelée lorsque l'URL \url{/my/shift} est
demandée. Cette dernière, après avoir vérifié le régime de travail de
l'utilisateur, va appeler la méthode de la vue principale qui correspond
au bon régime de travail. Ensuite, cette méthode, de la vue principale,
va appeler les méthodes, liées aux vues élémentaires qui sont utilisées
par cette vue principale.

![Le contrôleur du module *beesdoo_website_shift*. Les lignes commençant
par, *#*, regroupent les méthodes par utilité. Les lignes commençant
par, *- - - -*, indiquent les URL auxquels répond la méthode
précédente.](images/shift-controller.png){#fig:shift-controller
width=7cm}

![Diagramme représentant la succession d'appel de méthodes du contrôleur
générée lors de l'affichage de la page shift par un utilisateur. On y
voit](images/shift-activity.png){#fig:shift-activity width=100%}

La plupart des informations qu'il faut afficher à l'utilisateur sont
déjà définies dans le module *beesdoo_shift*. Cependant, ces
informations sont dispersées dans différents objets et ne sont pas
toujours dans des formats adéquats à une présentation simple et claire
de l'information. Les contrôleurs s'arrangent pour agréger ces
dernières.

Il y a cependant une information qui n'est pas disponible dans
*beesdoo_shift*. C'est la prochaine date à laquelle le travailleur
passera du statut « à jour » au statut « en alerte »
*(futur_alert_date)*. Cette information ne concerne que les travailleurs
inscrits en régime volant. Pour calculer cette date, il faut comprendre
comment fonctionne le changement de statut. Lorsque le travailleur
s'inscrit au régime volant, sa date d'inscription est enregistrée. À
partir de cette date, tous les 28 jours (4 semaines), son compteur de
*shift* sera décrémenté de un. Le compteur de *shift* est incrémenté de
un, à chaque fois que le travailleur réalise un *shift* dans le
supermarché. Lorsque le compteur est à zéro, il reste 28 jours au
travailleur pour faire un *shift* dans le supermarché avant de passer du
statut « à jour » à « en alerte ». Le nombre de jour, qu'il reste à un
travailleur pour faire un *shift* avant de passer au statut
« en alerte », se calcule de la manière suivante :

$$ days\_before\_alert = (shift\_counter + 1) \cdot 28 - delta \bmod 28 $$

Où $delta$ est le nombre de jours qui sépare la date d'inscription de la
date d'aujourd'hui et $shift\_counter$ le compteur de *shift* du
travailleur. L'expression, $\bmod$, représente la fonction modulo qui,
ici, retourne le reste de la division entière de $delta$ par $28$.

Cette date n'étant pas seulement utile pour le module
*beesdoo_website_shift*, elle a été placée dans le module
*beesdoo_shift*. De cette manière, elle est disponible via toutes les
interfaces d'Odoo.


## Réalisation


### Travailleur inscrit au régime régulier

![Page de gestion des *shifts* pour un travailleur en régime
régulier.](images/regular_worker_main_wide.png){width=100%}

![Travailleur régulier : la zone présentant le statut du
travailleur](images/regular_worker_status_holiday.png){width=100%}

![Les 13 prochains *shifts* du travailleur régulier. Un clique sur le
bouton « i » affiche les informations de contact du super-coopérateur du
*shift*.](images/regular_worker_next_shift.png){width=100%}

![L'affichage des *shifts* passés du travailleur
régulier.](images/regular_worker_past_shift.png){width=100%}

![Les textes d'aide pour le travailleur
régulier](images/regular_worker_help.png){width=100%}

\clearpage


### Travailleur inscrit au régime volant

![La zone d'affichage du statut du travailleur volant. Ici le
travailleur est en retard de deux *shifts* et est en alerte. Le cadis
vert indique qu'il peut cependant encore faire ses
courses.](images/irregular_worker_status_alert.png){width=100%}

![La zone d'affichage du statut d'un travailleur volant à jour. Les deux
*shifts* d'avance du travailleur lui permettent d'être à jour pendant
plusieurs semaines. La date avant laquelle le travailleur doit faire à
nouveau un *shift* est
indiquée.](images/irregular_worker_status_ok.png){width=100%}

![Dans l'image, le travailleur volant est suspendu. Le cadis rouge en
haut à droite indique qu'il ne peut plus faire ses courses dans le
supermarché tant qu'il n'a pas régularisé sa
situation.](images/irregular_worker_status_suspended.png){width=100%}

![La liste des futurs *shifts* disponibles pour le travailleur volant.
La mise en évidence des *shifts* et le nombre de *shifts* affichés sont
configurables via l'interface
d'administration.](images/irregular_worker_next_shift.png){width=100%}

![La fenêtre de validation après avoir cliqué sur bouton
« subscribe ».](images/irregular_worker_subscribe_validation.png){width=100%}

![Après s'être inscrit, le *shift* apparait dans la liste des prochains
*shifts*. Un retour est aussi donné à l'utilisateur en cas de réussite
et d'échec de
l'inscription.](images/irregular_worker_subscribe_feedback.png){width=100%}

![Les *shifts* passés du travailleur
volant.](images/irregular_worker_past_shift.png){width=100%}

![Les textes d'aide pour le travailleur
volant.](images/irregular_worker_help.png){width=100%}

\clearpage


### Travailleur exempté de travail

![Page de gestion des *shifts* d'un travailleur exempté de
travail.](images/exempted_worker.png){width=100%}

\clearpage


## Difficultés et solutions

Un des aspects du besoin qui a été sous-estimé lors de la conception est
l'affichage des *shifts* futurs pour un travailleur en régime
irrégulier. Pour comprendre pourquoi, il faut s'atteler à analyser le
fonctionnement actuel de l'outil de gestion des *shifts*.

Il y a quatre semaines différentes (semaines A, B, C et D). Le système
contient au plus quatre semaines de *shifts* dans le futur. Chaque fois
qu'une semaine se termine, la même semaine (A, B, C ou D) est à nouveau
générée. Par exemple, si la semaine A commence le 1 janvier et se
termine le 7 janvier, alors le 7 janvier le système génèrera la
prochaine semaine A qui se tiendra trois semaines plus tard, donc du 29
janvier au 4 février. Générer une semaine signifie que le système va
convertir les créneaux de la semaine concernée en *shifts*. Ce sont
ces *shifts* qui sont utiles pour l'affichage des informations dans
CoopShift.

La solution initiale pour afficher la liste des *shifts* futurs d'un
travailleur était de simplement lister les *shifts* futurs auxquels le
travailleur est inscrit et qui existent en base de données. Cela
fonctionne très bien pour les travailleurs en régime volant, mais pas
pour les travailleurs en régime régulier. En effet ces derniers ne
voyaient qu'un seul prochain *shift*, voir aucun juste après avoir
effectué leur *shift* car la nouvelle semaine qui correspond à leur
créneau n'a pas encore été générée par le système. Étant donné qu'il
fallait afficher les 13 prochains *shifts* pour un travailleur en régime
régulier, il fallait donc générer des *shifts* fictifs. L'adjectif
« fictif » est utilisé ici pour désigner le fait que ces *shifts* futurs
ne seront pas enregistrés en base de données pour ne pas perturber le
système de génération. Ils seront simplement calculés pour l'affichage.

Cette solution de générer des *shifts* fictifs comporte encore une
limitation. Il faudrait en effet tenir compte des jours fériés pendant
lesquels il n'y a pas de travail dans le supermarché. Pendant les jours
fériés, les travailleurs ne doivent pas venir faire leur *shift*. Il
faudrait donc, qu'un *shift* fictif tombant pendant un jour férié ne
soit pas affiché puisque celui-ci ne devra pas être effectué. Afin
de dépasser cette limitation, la solution proposée est de fournir une
interface pour encoder, à l'avance, les jours fériés pour les années à
venir. Cette solution globale permettrait au système qui génère
les *shifts* de, lui aussi, tenir compte des jours fériés. Pour
l'instant, les *shifts* qui tombent un jour férié sont supprimés
à la main après leur génération.

Un petit détail restait à régler pour l'affichage des *shifts* fictifs.
Les heures de début et de fin de *shift* étaient décalées d'une heure
après les dates de changement d'heure légale. La génération se passe
comme suit :

1. Un *shift* existant appartenant au créneau horaire du travailleur est
   récupéré dans la base de données.
1. Une copie de ce *shift* est réalisée et constitue un *shift* fictif.
1. Un multiple de 28 jours (l'équivalent en jour de quatre semaines) est
   ajouté aux dates de début et de fin du *shift* fictif.

Toutes les dates, enregistrées dans la base de données et stockées dans
les objets, sont enregistrées comme étant des dates UTC (temps universel
coordonné). L'UTC ne connait pas le changement d'heure été/hiver.  Il
permet d'être une référence commune pour toutes les heures du globe.
C'est lors de l'affichage d'une date que celle-ci est transformée en
heure locale en utilisant le fuseau horaire défini dans les paramètres
d'Odoo ou de l'utilisateur. Afin de construire les *shifts* fictifs, la
première réalisation ajoutait simplement les 28 jours en plus à la date
à l'heure UTC du *shift* de départ. Ce qui impliquait un décalage des
heures de début et de fin de *shift* aux passages à l'heure d'été et à
l'heure d'hiver. En effet, à l'heure d'hiver belge, un *shift* qui
commence à 12h, heure légale belge, se passe à en réalité à 11h, heure
UTC. Le même *shift* réalisé, à l'heure d'été belge, qui commence
toujours à 12h, heure légale belge, se passe à 10h, heure UTC. Cela est
dû au fait qu'en hiver l'heure légale belge est UTC+1 et en été l'heure
légale belge est UTC+2. Il faut donc que l'ajout des jours tienne compte
de ce changement d'heure afin de le répercuter à l'heure UTC stockée
dans le *shift*.  L'ajout des jours se fait via la méthode *timedelta()*
du module *datetime* de Python.

Pour comprendre le problème, il faut comprendre comment Python gère les
dates et les heures. Il y a deux types de date différentes : les dates
brutes qui ne sont liées à aucun fuseau horaire appelées *naïves* et les
dates qui sont liées à un fuseau horaire appelées *non-naïves*.
Lorsqu'on ajoute un nombre de jours à une date non-naïve, le fuseau
horaire est laissé intacte. Une date, avant le changement d'heure, qui
est liée au fuseau horaire UTC+1, après l'ajout d'un nombre de jour qui
la fait passer à une date après le changement d'heure, conserve le
fuseau horaire UTC+1 là où elle devrait se voir attribué le fuseau
horaire UTC+2. La solution est donc de corriger le fuseau horaire une
fois la date modifiée afin que la conversion vers l'heure UTC répercute
bien le changement d'heure.
