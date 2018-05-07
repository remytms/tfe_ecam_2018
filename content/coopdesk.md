# CoopDesk : l'interface entre les coopérateurs et la coopérative {#sec:coopdesk}

> **TODO** : Voir si le titre énonce clairement que ce chapitre donne
> une vue globale sur le reste du document.

Ce chapitre donne une vue globale sur le travail réalisé. Les éléments
de détails se trouveront dans les chapitres suivants.


## Le besoin

BEES coop compte quelque 2000 coopérateurs. Ces derniers sont à la fois
propriétaires, travailleurs et clients de la coopérative. Chaque
coopérateur a donc trois casquettes différentes.

En sa qualité de propriétaire, le coopérateur veut pouvoir obtenir
facilement son certificat de coopérateur, ainsi que différentes
attestations fiscales lui permettant de prouver sa participation à la
coopérative. Il veut aussi avoir accès aux informations personnelles que
la coopérative détient à son sujet (adresse, compte bancaire, etc.) afin
de pouvoir rectifier ces derniers en cas d'erreur. Il veut connaitre
l'état de ses parts dans la coopérative (combien de parts, quel type de
part, la date de prise de part, etc.). La possession de parts donne
droit au coopérateur de participer aux processus démocratiques de la
coopérative, c'est pourquoi il souhaite avoir accès aux rapports des
différentes assemblées, ainsi qu'aux textes des règlements.

En sa qualité de travailleur, le coopérateur veut faire un suivi de son
travail au sein de la coopérative. Ce travail conditionne le droit de
faire ses courses dans le supermarché, c'est pourquoi il veut connaitre
son statut à tout instant, les dates de ses prochains *shifts* de
travail et les dates clés qui modifient son statut (date d'alerte, date
de congé, etc.). Le coopérateur peut autoriser jusqu'à deux personnes à
faire leurs courses dans le supermarché à sa place, c'est une
information à laquelle le coopérateur doit avoir accès afin de la
modifier si nécessaire.

En sa qualité de client, le coopérateur veut avoir accès à ses tickets
de caisses pour les achats passés dans le supermarché.

Ce service au coopérateur est actuellement réalisé par le service
administratif de la coopérative. À la vue du nombre élevé de
coopérateurs cela monopolise beaucoup de ressources humaines. La
coopérative préfère mettre ses ressources humaines au travail pour la
réalisation de son objet social et de ses finalités sociales. CoopDesk
doit donc être un outil qui, en plus de fournir les services énoncés
ci-dessus, devra permettre de réduire le nombre de personnes mises à
disposition pour réaliser ces services. La coopérative utilise le
logiciel Odoo Community comme ERP *(Entreprise Resource Planning)*,
CoopDesk doit donc être totalement intégré à Odoo.


## Conception {#sec:coopdesk-conception}

Odoo est un logiciel orienté web. Un serveur (en général dans le
*cloud*) fait tourner une instance d'Odoo et une base de données
(PostgreSQL). Les utilisateurs interagissent avec Odoo via le navigateur
internet de leur poste de travail. Odoo est écrit en Python. Il est
constitué d'un *framework*, qui fournit un ORM *(Object-Relational
Mapping)*, et des fonctionnalités de base qui rendent possible la
création de modules. Ces modules forment des applications qui
interragissent les unes avec les autres pour fournir un tout cohérent.
Dans sa version Community une série de modules est fournie et ajoute les
fonctionnalités qui font d'Odoo Community un ERP.

La principale manière pour un utilisateur d'interagir avec Odoo est via
son interface d'administration. Cette interface est très fournie en
fonctionnalités. Cette interface est normalisée afin de fournir à
l'utilisateur une utilisation similaire quels que soient les modules
qu'il utilise. Odoo fournit aussi une autre interface dite de *website*,
plus proche d'un site web et qui laisse une plus grande liberté de
création dans l'interface. C'est cette dernière interface qui sera
utilisée pour la réalisation de CoopDesk, car elle offre une liberté qui
va permettre de concevoir une interface simple et efficace, proche de ce
que l'utilisateur a l'habitude de rencontrer lorsqu'il navigue sur le
web. Mais aussi, afin de ne pas fournir un accès, à tous les
utilisateurs, à l'interface d'administration et ainsi les cantonner dans
une interface *website* qui ne contient que les fonctionnalités qu'ils
ont besoin. Cependant l'interface d'administration sera utilisée pour ce
qui concerne l'administration et la configuration de CoopDesk.

> **TODO** : Ajouter deux images qui illustrent l'interface
> d'administration et *website*.

CoopDesk doit répondre aux besoins de la BEES coop. Cependant, il serait
beaucoup plus utile qu'il puisse également être utilisé par d'autres
coopératives qui ont des besoins similaires. Afin que cela soit
possible, il faut que CoopDesk soit modulable de façon à ce que chaque
coopérative puisse prendre les fonctionnalités qui l'intéressent sans
s'encombrer des fonctionnalités dont elle n'a pas besoin. Il faut aussi
que CoopDesk puisse facilement être complété par d'autres
fonctionnalités. Le premier travail de conception consiste donc à
découper CoopDesk en modules, chaque module faisant un ensemble de
tâches indissociables. De manière à ce que les modules soient le plus
possible découplés les uns des autres.

La figure \vref{fig:intranet_package} illustre les différents modules
qui composent CoopDesk ainsi que la structure et les dépendances qu'ils
ont entre eux. De plus, cette figure indique les modules existants
sur lesquels CoopDesk s'appuie. Les petites boites grises représentent
les modules existants tandis que les grandes boites blanches
représentent les modules à développer. Les cadres en pointillé
regroupent les modules, par thématique, que l'on peut comparer à des
applications, car les modules qui en font partie forment un tout
cohérent. Ce sont ces thématiques qui serviront de découpage à cet
ouvrage.

![Structure et dépendances entre les modules qui composent CoopDesk. En
petit et gris, les modules déjà existants. En grand, les modules à
développer. Les encadrés regroupent les modules par thématiques. Les
flèches indiquent les dépendances entre les
modules.](images/intranet_package.png){#fig:intranet_package
height=150%}


### Modules existants

Cette section décrit les modules existants sur lesquelles CoopDesk a été
construit. Ces modules sont représenté dans la
figure \ref{fig:intranet_package}.


##### Website Portal v10

Ce module est un *backport* du module standard d'Odoo qui se nomme
*website_portal*. Ce dernier apporte une interface type *website* où
l'utilisateur peut consulter ses informations personnelles de base (nom,
prénom, adresse électronique, adresse postale) et modifier ces dernières
via un formulaire. CoopDesk est réalisé sur la version 9 d'Odoo.
Cependant la version 10 apporte une amélioration quant au design de
ce module. C'est pourquoi il a été choisi de travailler avec ce
*backport* de manière à profiter de l'interface améliorée et de pouvoir
plus facilement migrer plus tard vers la version 10.

##### Easy My Coop

Ce module contient toute la gestion des coopérateurs et de leurs parts
dans une coopérative. C'est dans ce module que l'on trouvera toutes les
informations telles que le nombre de parts, le type de part, la date
d'entrée dans la coopérative, le numéro de coopérateur, etc.

##### Easy My Coop Taxshelter Report

Ce module apporte la gestion du « tax shelter ». Ce dernier est une
attestation qui donne droit en Belgique à une réduction d'impôt pour le
montant investi dans une nouvelle société. Les nouvelles coopératives
peuvent faire profiter leurs coopérateurs de cet avantage.

##### Beesdoo Base

Ce module est un module lié au fonctionnement particulier de la
BEES coop. Ce qui nous intéresse dans ce module, c'est la définition des
mangeurs pour chaque coopérateur. Les mangeurs sont les personnes
autorisées, par le coopérateur, à venir faire les courses à la place de
ce dernier.

##### Point of Sale

Ce module fournit les fonctionnalités liées à la gestion d'un point de
vente. C'est donc là que se retrouvent les tickets de caisse de chaque
coopérateur.

##### Beesdoo Shift

Ce module apporte la gestion du travail des coopérateurs. C'est là que
se trouve les *shifts*, les présences et le statut de chaque
coopérateur.  C'est aussi via ce module que l'on peut inscrire un
coopérateur à un *shift*.


### Modules à développer

Cette section parcours toutes les applications qui composent CoopDesk et
décrit, pour chacune, les modules qui la compose. Ces applications sont
représentées par les encadrés en pointillé dans la
figure \ref{fig:intranet_package}.


#### CoopShift

Cette application ne contient qu'un seul module :
*beesdoo_website_shift*. Ce module vient apporter une interface
*website* pour que chaque coopérateur-travailleur puisse avoir accès
à ses informations de travailleur telles que ses prochains *shifts*, ses
*shifts* passés, son statut, s'il lui est possible de faire ses
courses, etc.


#### CoopInfoPerso

Cette application couvre les aspects liés aux informations personnelles
du coopérateur. Elle est composée de 5 modules.

##### Website Portal Extend

Ce module dépend de *website_portal_v10*. Ce dernier n'a pas été conçu
pour être étendu ou modifié. De plus, la gestion du cas où le
coopérateur est une personne morale telle une ASBL ou une autre
coopérative n'est pas optimale. Ce module vient donc réorganiser le code
afin d'apporter une meilleure gestion des personnes morales et rendre
facilement changeable quelles informations sont affichées et quelles
informations sont modifiables.

##### Beesdoo Website Portal

Ce module s'appuie sur le module *website_portal_extend* afin de venir
limiter les informations qui sont modifiables par le coopérateur. Par
défaut le module *website_portal_v10* permet au coopérateur de modifier
librement toutes les informations le concernant. La BEES coop souhaite
que certaines informations nécessaires à son fonctionnement ne soient
pas modifiables directement par le coopérateur. Seul le numéro de
téléphone et l'adresse postale restent modifiables par le
coopérateur. Pour le reste, le coopérateur doit passer par
l'administration de la coopérative.

##### Easy My Coop Website Portal

Ce module apporte une interface *website* pour que le coopérateur
puisse avoir accès à ses informations de coopérateur, son
certificat de coopérateur et à chacune des demandes de
libération de capital qui lui ont été demandées.

##### Easy My Coop Website Taxshelter

Ce module vient compléter le module *easy_my_coop_website_portal* afin
que le coopérateur puisse avoir accès aux attestations de participation
lui permettant de bénéficier du « tax shelter » en Belgique.

##### Beesdoo Website Eater

Ce module complète le module *website_portal_v10* en affichant les
mangeurs qui sont liés au coopérateur.


#### CoopDocument

Cette application se compose de deux modules. Le but est de pouvoir
mettre à disposition des coopérateurs les documents de la coopérative
qui les concernent comme, par exemple, les rapports de réunion et
d'assemblée.

##### Easy My Coop Document

Ce module fournit une interface d'administration pour la gestion des
documents de la coopérative. C'est via cette interface que les documents
sont téléversés et que ses propriétés de publication sont définies.

##### Easy My Coop Website Document

Ce module fournit une interface *website* pour que le coopérateur
puisse facilement accéder aux documents publiés par la coopérative.


#### CoopReceipt

Cette application est composée d'un seul module qui vient compléter le
module *website_portal_v10* pour y ajouter une interface *website*
pour que le coopérateur puisse accéder à ses tickets de caisse.

> **TODO** : Parler du module de thème.


## Réalisation

Afin de savoir par quoi commencer, les différentes thématiques ont été
priorisées. Cet ouvrage les présentent dans l'ordre du plus urgent au
moins urgent.

> **TODO** : Mettre à jour les dates dans ces paragraphes.

La réalisation a débuté par un apprentissage de la programmation sous
Odoo concernant l'interface *website*. L'apprentissage d'Odoo est
vaste, c'est pourquoi, afin de mettre la théorie en pratique, la
réalisation de CoopShift a débuté en parallèle. Par la suite,
apprentissage et développement ont eu lieu de manière
concomitante.

La réalisation de :

- CoopShift s'est déroulée de septembre à juin avec deux versions
  principales publiées. La première en janvier et la deuxième en avril.
  Plus de détails sont disponibles dans la
  partie \nameref{sec:coopshift} \vpageref{sec:coopshift}.
- CoopInfoPerso a débuté en janvier et s'est clôturée en XXXX.
  Plus de détails sont disponibles dans la
  partie \nameref{sec:coopinfoperso} \vpageref{sec:coopinfoperso}.
- CoopDocument a commencé en mars et s'est terminée en XXXX.
  Plus de détails sont disponibles dans la
  partie \nameref{sec:coopdocument} \vpageref{sec:coopdocument}.
- CoopReceipt a débuté en avril et s'est terminée en XXXX.
  Plus de détails sont disponibles dans la
  partie \nameref{sec:coopreceipt} \vpageref{sec:coopreceipt}.

> **TODO** : Mettre à jour les informations concernant les réunions.

Au total quatre réunions ont été organisées avec la BEES coop. La
première a eu lieu en septembre afin de définir le cahier des charges
et de prioriser les développements. La deuxième a eu lieu début
décembre pour y présenter le travail fait sur CoopShift. La troisième
a eu lieu fin janvier pour y présenter la première version fonctionnelle
de CoopShift. La quatrième a eu lieu début avril pour y présenter
l'avancement sur CoopInfoPerso, CoopDocument et la deuxième version de
CoopShift.


## Difficultés et solutions

> **TODO** : L'expression « la raideur de la courbe d'apprentissage »
> n'est pas appropriée.

La première difficulté qui me vient à l'esprit est la raideur de la
courbe d'apprentissage de la programmation sous Odoo. En effet, Odoo
n'est pas aussi populaire que d'autres logiciels libres qui brassent des
milliers de développeurs et pour lesquels la documentation foisonne à
volonté sur le web. Pour Odoo les ressources en ligne sont les
suivantes :

- Le livre *Odoo essentials* qui fournit une vue globale de ce qui est
  possible de faire avec Odoo à destination des débutants dans la
  programmation avec Odoo.
- Le livre *Odoo cookbook* qui fournit des exemples et des explications
  concernant les cas de figure les plus récurants dans la programmation
  avec Odoo. Il est à destination des personnes ayant déjà développé
  sous Odoo.
- La documentation de la nouvelle API d'Odoo qui n'est pas toujours
  suffisamment détaillée, mais qui permet de voir ce qui existe. Il est
  alors possible d'aller voir dans le code pour avoir plus de détails.
- Le forum officiel d'Odoo SA.
- Quelques questions sur *Stack Exchange* et autres tutoriels ou blog
  sur des sujets précis.

La solution la plus efficace reste de chercher un autre module dans Odoo
qui fait quelque chose de similaire à notre but et de lire le code
correspondant. Il va cependant sans dire qu'un contact humain avec un
expert Odoo est toujours plus rapide et permet d'éviter de se lancer
dans de fausses solutions, cela permet aussi de mettre de l'ordre dans
ses idées par le fait de devoir expliquer notre but et la manière dont
on compte y arriver.

Une deuxième difficulté est d'arriver à se situer parmi la quantité de
modules dont Odoo dispose. Il faut du temps pour trouver tous les
modules qui interviennent dans une application donnée et comprendre ce
que chacun d'eux apporte. C'est une fois qu'on a compris cela qu'on peut
alors se mettre à développer juste ce qu'il faut pour ajouter la
fonctionnalité souhaitée.

Enfin Odoo est un logiciel modulable, cela lui permet de répondre à de
nombreux cas d'utilisation. Il en va de même lorsqu'on construit une
application pour Odoo. C'est pourquoi une même application peut être
composée de plusieurs modules. C'est le cas par exemple pour
CoopInfoPerso qui peut être composée avec plus ou moins de modules en
fonction de ce que l'on a besoin. Ainsi une coopérative qui ne veut pas
émettre de « tax shelter » peut très bien profiter de l'application
CoopInfoPerso sans le module *easy_my_coop_website_taxshelter*.
