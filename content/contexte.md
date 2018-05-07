# Contexte {#sec:contexte}

Ce chapitre présente les éléments de contexte nécessaire à la
compréhension de l'environnement dans lequel ce travail a été réalisé.


## Qu'est-ce que la BEES coop

La Coopérative Bruxelloise, Écologique, Économique et Sociale
(BEES coop) est un supermarché coopératif et participatif. Le but de la
BEES coop est de permettre à ses membres d'avoir un accès bon marché à
des produits de consommation bio, locaux, éthiques et en vrac. Mais
aussi de permettre à ses membres de prendre une part active dans la
gestion du magasin et de la coopérative afin de se rapproprier leur
manière d'acheter et de se nourrir. Pour ce faire elle favorise les
circuits courts et se positionne comme acteur de l'économie sociale.


### Une coopérative acteur de l'économie sociale et locale

Les coopératives sont une forme d'entreprise dont le capital est
variable. Les personnes qui détiennent une part du capital sont appelées
coopérateurs. Il est possible pour le coopérateur de retirer ses parts
de la coopérative ou d'en prendre plus ce qui fait varier le capital
social de la coopérative. Les valeurs portées par le mouvement
coopératif, font, des coopératives, des acteurs privilégiés de
l'économie sociale.

L'économie sociale regroupe les acteurs économiques qui partagent
certaines valeurs qui diffèrent des valeurs portées par les acteurs de
l'économie classique. Ces valeurs sont les suivantes \cite{conf:ecoso} :

- **Autonomie de gestion** : Les acteurs sont des acteurs privés qui ne
  sont pas contrôlés par l'état ou par d'autres structures. Seuls les
  propriétaires ou membres gèrent l'organisation.
- **Processus de décision démocratique** : L'organisation est gérée
  démocratiquement selon le principe de : un humain, une voix.
  Cependant, certains acteurs souhaitent donner plus de voix à d'autres,
  cela se fait alors dans un cadre très strict qui empêche une personne
  d'avoir une voix prépondérante.
- **Pas de but de profit** : Les acteurs de l'économie sociale se
  concentrent sur leur but social. Ils ne courent aucun but de profit.
  Pour ce faire, le capital n'est pas ou peu rémunéré. Si elle est
  rémunérée c'est dans une limite de 6 % de la part
  investie. \cite{loi:cnc}
- **Priorité au travail**: Dans la redistribution des revenus, une
  priorité est de rémunérer d'abord le travail.

Afin de mettre en œuvre ces principes démocratiques et de permettre à
ses membres de devenir acteurs de leurs achats, la BEES coop s'est dotée
d'une gestion démocratique unique \cite{site:fonctionnement-beescoop} :

- **L'assemblée générale** : C'est l'ensemble de tous les coopérateurs.
  Elle élit le conseil d'administration ansi que le comité sociétal.
  Elle prend les décisions stratégiques pour la coopérative.
- **Le comité transversal et le conseil d'administration** : Le comité
  transversal est composé de représentants élus dans chaque comité. Ces
  deux organes prennent ensemble les décisions tactiques pour la
  coopérative.
- **Les comités** : Ce sont de petits groupes de coopérateurs qui se
  spécialisent dans un domaine de la gestion de la coopérative. Ils ne
  sont pas élus, mais participent activement au fonctionnement de la
  BEES coop. Elles prennent les décisions opérationnelles au jour le
  jour.
- **Le comité sociétal** : Ces membres sont élus par l'assemblée
  générale. Il a un rôle d'observateur et s'assure que les finalités
  sociales de BEES coop sont respectées.

Les comités de la BEES coop jouent un grand rôle dans les décisions
journalières. Elles ont participé activement à l'élaboration du cahier
des charges de ce travail.

> **TODO**: Parler des finalités sociales. Mais il y en a beaucoup, il
> faut les résumer…


### Un supermarché coopératif et participatif

Afin d'atteindre son objectif « bon marché », les coopérateurs de la
BEES coop fournissent 3h de travail bénévole dans la coopérative toutes
les quatre semaines. Ce qui leur donne le droit de faire leurs courses
dans le supermarché. Le travail des coopérateurs s'organise autour de
deux régimes différents. Le régime dit régulier et le régime dit volant.
Le temps est divisé en quatre semaines distinctes (A, B, C et D) qui se
suivent successivement durant toute l'année. Chaque semaine comporte
plusieurs jours de travail. Ces jours de travail sont découpés en
plusieurs morceaux de 3h. Pour chaque morceau de 3h, il peut y avoir
différents groupes de tâches à faire.


### Un modèle ouvert

Pour pouvoir fonctionner correctement, la BEES coop doit rester à taille
humaine. Cependant, elle ne souhaite pas rester une expérience isolée,
mais au contraire, permettre à un maximum de personnes de se
réapproprier leur alimentation. C'est pourquoi, elle souhaite partager
le modèle sur lequel elle est basée. Mais aussi les connaissances
qu'elle a apprise tout au long de sa création et de son fonctionnement.
C'est pourquoi, en ce qui concerne la partie informatique, la BEES coop
a choisi d'utiliser le plus possible de logiciels libres. En effet, la
philosophie de partage des connaissances et de libre diffusion que ces
derniers défendent rend possible la volonté de la BEES coop de voir son
modèle être repris et créer à nouveau par d'autres personnes. C'est donc
tout naturellement qu'elle s'est tournée vers Odoo comme logiciel de
gestion pour la coopérative.


## Qu'est-ce qu'Odoo

Odoo est le nom d'un logiciel libre de gestion d'entreprise (*Entreprise
Ressource Planning*, ERP). C'est aussi le nom de la société anonyme du
même nom : Odoo SA. C'est une société belge fondée par
Fabien \textsc{Pinckaers}. \cite{site:odoo-about}

Odoo est un logiciel qui a pour but de simplifier la gestion
d'entreprise dans son ensemble. \cite{wiki:odoo} Il est composé de
différents modules qui sont autant de petites applications travaillant
toutes dans un même environnement. L'entreprise a donc toutes ses
données centralisées dans une seule base de donnée. Voici quelques
applications phares :

- gestion des relations clients ;
- gestion des ventes ;
- gestion de production ;
- gestion des stocks ;
- gestion des ressources humaines ;
- gestion de projets ;
- gestion comptable ;
- etc.

Odoo SA s'occupe de maintenir et de développer deux versions d'Odoo :
Odoo Community et Odoo Entreprise.

- **Odoo Community** est un logiciel libre sous licence LGPL *(GNU
  Lesser General Public Licence)*. C'est le cœur d'Odoo. Il contient les
  fonctionnalités vitales et basiques d'Odoo.
- **Odoo Entreprise** est une couche logicielle propriétaire qui
  s'ajoute à Odoo Community. Cette couche propriétaire apporte des
  fonctionnalités supplémentaires.

Bien souvent, les processus de productions d'une entreprise ne sont pas
les même. C'est pourquoi, il faut adapter Odoo à ces processus. Odoo SA
fournit, avec ses partenaires, ce service de personnalisation d'Odoo
Entreprise. De même, pour Odoo Community, d'autres sociétés fournissent
des services de personnalisation, similaire à ceux d'Odoo SA. C'est
dans ce cadre qu'Open Architects Consulting travaille.


## Qu'est-ce qu'Open Architects Consulting

Open Architects Consulting est une SPRL dirigée par
Houssine \textsc{Bakkali}, qui intègre Odoo Community pour ses clients.
Les développements réalisés par Open Architects Consulting sont placés
sous licence libre et peuvent être réutilisés par d'autres.

Open Architects Consulting fournit les services suivant à des tarifs
différentiés en fonction de la situation économique du client. Cela
permet aux entreprises, qui se portent bien, de soutenir des entreprises
qui démarrent ou qui ont moins de facilités financières.

Open Architects Consulting fournis les services suivant :

- **Analyse** les besoins métiers au sein de l'entreprise et proposent
  des solutions efficaces à ses besoins.
- **Personnalise** Odoo pour correspondre aux besoins définis lors de
  l'analyse.
- **Forme** les clients afin qu'ils soient autonomes dans l'utilisation
  quotidienne d'Odoo.
- **Accompagne** les clients tout au long de leur utilisation d'Odoo en
  proposant des services d'aide et d'hébergement d'Odoo.

C'est le partenariat avec Open Architects Consulting qui a rendu
possible la réalisation de ce travail.
