# Conception générale {#sec:conception}

Ce chapitre présente d'une manière globale le besoin exprimé par la
BEES coop. Il donne les éléments techniques nécessaires à la
compréhension de l'ouvrage et termine par exposer la conception de
CoopDesk dans son ensemble. CoopDesk étant composée de plusieurs
applications, chacune d'elle est détaillée dans un chapitre dédié.


## Le besoin

BEES coop compte quelque 2000
coopérateurs. \cite{site:inauguration-beescoop} Ces derniers sont à la
fois propriétaires, travailleurs et clients de la coopérative. Chaque
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


## Les aspects techniques d'Odoo

Odoo est un logiciel orienté web. \cite{bk:odoo} Un serveur (en général
dans le *cloud*) fait tourner une instance d'Odoo et une base de données
(PostgreSQL). Les utilisateurs interagissent avec Odoo via le navigateur
internet de leur poste de travail. Le cœur d'Odoo est écrit en Python.
Il est constitué d'un *framework*, qui fournit un ORM
*(Object-Relational Mapping)*, \cite{site:orm} et des fonctionnalités de
base qui rendent possible la création de modules. Ces modules forment
des applications qui interagissent les unes avec les autres pour fournir
un tout cohérent. Dans sa version Community une série de modules est
fournie et apporte les fonctionnalités qui font d'Odoo Community un ERP.
Le caractère modulable d'Odoo fait de lui un logiciel très puissant car
par l'ajout de modules, on peut adapter Odoo à tout type de structure
d'entreprise et tout type de procédé.

L'ORM s'occupe de faire la liaison entre les objets Python et la base de
données PostgreSQL. Cet ORM gère la plupart des cas de relations entre
objets : *One2One*, *Many2One*, *One2Many* et *Many2Many*.

Odoo utilise Werkzeug \cite{site:werkzeug} comme serveur WSGI. WSGI est
un protocole de discussion entre un serveur web (Nginx, Apache, etc.) et
une application Python. Le serveur web transforme les requêtes HTTP en
objet Python compatible WSGI. De même, il est capable de donner une
réponse sous forme d'objet Python compatible WSGI en une réponse HTTP
classique.

Odoo étant une application web son *frontend* (interface utilisateur)
est principalement du JavaScript, de l'HTML et du CSS. Ce dernier
s'écrit à l'aide d'une série de vue *(templates)*. Ces vues sont écrites
en QWeb, un moteur de génération de vues XML. \cite{site:odoo-qweb} QWeb
permet de traiter les données par des boucles ou des conditions. Il
permet aussi de traiter les différents type de champs et de données afin
qu'elles s'affichent proprement. QWeb permet aussi l'utilisation de
XPath afin d'aller modifier des vues déjà existantes.


## Le patron de conception MVC

Odoo fonctionne selon de patron de conception MVC
(modèle-vue-contrôleur). Cette manière de programmer est très présente
dans le domaine des sites internet. Trois acteurs sont présents dans
cette manière de programmer : le modèle qui contient les données, la vue
qui affiche les données et le contrôleur qui fait le pont entre les
modèles et les vues.

![Diagramme schématisant le rendu d'une page \url{/my/order/} par un
système MVC.](images/mvc_sequence.png){#fig:mvc-sequence height=14cm}

Tout d'abord, les modèles, qui sont des objets Python, suivent les
règles de l'ORM afin d'être stockés automatiquement en base de données
par ce dernier. Il y a un modèle pour chaque type d'information que l'on
veut conserver en base de données. Les modèles sont décrits à l'aide de
classe Python. Par exemple, le modèle *res.user* représente un
utilisateur d'Odoo, le modèle *res.partner* représente un contact, le
modèle *pos.order* représente une commande à un point de vente *(Point
of Sale, POS)*, etc.

Ensuite, il y a les vues *(templates)* qui sont écrite en QWeb et qui se
charge d'afficher des données d'une manière plaisante pour
l'utilisateur. Les vues ne sont pas censée travailler ou modifier les
données qu'elles reçoivent du contrôleur. Par contre, elles vont gérer la
manière d'afficher la donnée selon son contenu ou selon des paramètres
donnés. Par exemple, une vue peut afficher la commande d'un point de
vente *(pos.order)*. Dans cet affichage, par exemple, le
nom du client qui sera affiché plus grand que le reste des informations,
ou encore la TVA qui sera affichée en italique. 

Enfin, il y a les contrôleurs qui sont des programmes qui viennent faire
le lien entre les modèles et les vues. Dans du développement web, un
contrôleur est en général lié à une URL. En effet chaque URL correspond
à une page différente. Cette URL peut contenir des paramètres qui sont
passé au contrôleur. Le contrôleur se charge d'observer les paramètres
reçus afin d'afficher la page demandée. Il s'occupe d'aller chercher le
modèle adéquat et de récupérer les informations qu'il contient. Il peut
ensuite effectuer une série de traitement sur ces données, par exemple,
les filtrer ou les trier. Il termine par préparer toutes les données
afin qu'elles soient prêtes pour que la vue les affiche. Il va alors
appeler la vue correspondante en lui donnant les données en question. La
page sera alors affichée à l'utilisateur.


## Conception {#sec:coopdesk-conception}

La principale manière pour un utilisateur d'interagir avec Odoo est via
son interface d'administration (voir figure \vref{fig:admin-interface}.
Cette interface est très fournie en fonctionnalités. Cette interface est
normalisée afin de fournir à l'utilisateur une utilisation similaire
quels que soient les modules qu'il utilise. Odoo fournit aussi une autre
interface dite de *website* (voir figure \vref{fig:website-interface},
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

![L'interface d'administration d'Odoo, aussi appelée l'interface du
*backend* dans le jargon. Ici l'interface affiche la liste des
modules Odoo qui peuvent être
installés.](images/admin_interface.png){#fig:admin-interface width=100%}

![L'interface *website* d'Odoo, aussi appelée l'interface *frontend*
dans le jargon. Ici, la page « Contactez-nous » est affichée. Il est à
noté que le graphisme de la BEES coop est
installé.](images/website_interface.png){#fig:website-interface
width=100%}

CoopDesk doit répondre aux besoins de la BEES coop. Cependant, il serait
beaucoup plus utile qu'il puisse également être utilisé par d'autres
coopératives qui ont des besoins similaires. Afin que cela soit
possible, il faut que CoopDesk soit modulable de façon à ce que chaque
coopérative puisse prendre les fonctionnalités qui l'intéressent sans
s'encombrer des fonctionnalités dont elle n'a pas besoin. Il faut aussi
que CoopDesk puisse facilement être complété par d'autres
fonctionnalités. Le premier travail de conception consiste donc à
découper CoopDesk en modules, chaque module faisant un ensemble de
tâches indissociables. De manière à ce que les modules soient, le plus
possible, découplés les uns des autres.

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
height=14cm}


### Modules existants

Cette section décrit les modules existants sur lesquelles CoopDesk a été
construit. Ces modules sont représentés dans la
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

Ce module apporte la gestion du Tax Shelter. \cite{site:taxshelter} Ce
dernier est une attestation qui donne droit en Belgique à une réduction
d'impôt pour le montant investi dans une nouvelle société. Les nouvelles
coopératives peuvent faire profiter leurs coopérateurs de cet avantage.

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
coopérateur. C'est aussi via ce module que l'on peut inscrire un
coopérateur à un *shift*.


### Modules à développer

Cette section parcourt toutes les applications qui composent CoopDesk et
décrit, pour chacune, les modules qui la composent. Ces applications sont
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


#### Charte graphique de la BEES coop

La charte graphique de la BEES coop est implémentée dans le module
*beesdoo_website_theme*. Il s'agit de mettre en œuvre dans ce module les
principaux éléments graphique qui permettre de reconnaitre la BEES coop
et de rendre la transition, pour l'utilisateur, entre le site internet
de la BEES coop et l'interface d'Odoo agréable.

