# CoopInfoPerso : la gestion des informations personnelles {#sec:coopinfoperso}

Ce chapitre traite de l'application fournissant une interface pour que
le coopérateur puisse consulter les informations personnelles, le
concernant, possédées par la coopérative, et modifier certaines d'entre
elles ou modifier l'ensemble de ses informations de coopérateur, y
compris, l'accès aux divers certificats.


## Le besoin

La BEES coop, étant une coopérative, doit respecter certaines
obligations légales, notamment tenir un registre des parts. Pour ce
faire, elle a besoin de connaitre certaines informations personnelles
des coopérateurs. De plus beaucoup de coopérateurs sont aussi
travailleurs dans le supermarché, la coopérative a aussi besoin
d'informations personnelles pour organiser le travail dans le magasin.
Toutes ces informations, à caractère personnel, sont soumises à des lois
de protection de la vie privée. Les coopérateurs ont un droit de regard,
de modification et de suppression (dans le respect du cadre légal) de
ces informations dans la mesure où elles leur appartiennent. Afin d'en
faciliter la gestion administrative, la BEES coop souhaite que certaines
informations puissent être corrigées directement par le coopérateur.
Cependant, la modification des informations qui font l'objet
d'obligations légales pour la coopérative elle-même ne seront modifiées
que par un responsable de la coopérative après une demande écrite du
coopérateur. Ceci afin d'éviter que des informations importantes ne
soient modifiées ou supprimées par erreur.

Chaque coopérateur possède des parts de la coopérative. Ces parts
peuvent être acquises en une fois où en plusieurs fois. Elles peuvent
aussi faire l'état de revente entre coopérateur où de revente à la
coopérative. La BEES coop souhaite que chacun de ses coopérateurs puisse
voir l'état de sa participation financière dans la coopérative ;
c'est-à-dire, le nombre de parts possédées, depuis quand, pour quel
montant total, etc. Aussi, la coopérative fournit au coopérateur un
certificat de participation lorsque ce dernier achète des parts. La
BEES coop souhaite que les coopérateurs puissent avoir un accès en
permanence à ce certificat afin d'alléger la charge administrative de la
coopérative. Enfin, lors d'une demande de prise de parts d'un citoyen,
la BEES coop lui transmet une demande de libération de capital.  La
BEES coop souhaite que cette dernière soit disponible au coopérateur à
tout moment, toujours dans le but d'alléger sa charge administrative et
dans le cas, par exemple, où des coopérateurs perdraient les documents
reçus.

Il est une particularité fiscale, en Belgique, nommée
Tax Shelter. \cite{site:taxshelter} Ce nom désigne un avantage fiscal
donné aux personnes qui investissent de l'argent dans des entreprises
nouvelles afin de favoriser la création d'entreprise par une levée de
capital plus facile, encouragée par cette réduction d'impôt. Cela
jusqu'à ce que l'entreprise ai levé un certain montant de capital. La
BEES coop étant une nouvelle entreprise fondée en 2016 \cite{site:bce},
les premiers coopérateurs peuvent bénéficier d'une réduction d'impôt sur
l'argent investi dans la coopérative. De ce fait la BEES coop souhaite
que chaque coopérateur puisse avoir un accès permanent aux certificats
qui leur permettront de justifier leur participation financière dans la
coopérative auprès des autorités.

> **TODO** : Parler de l'affichage des mangeurs.

Donc pour résumer, CoopInfoPerso doit fournir une interface agréable ou
les coopérateurs pourront consulter sans difficultés :

- les informations personnelles les concernant à savoir : le nom, le
  prénom, l'adresse postale, le numéro de téléphone, l'adresse
  électronique, le numéro de compte bancaire et le numéro de registre
  national ;
- les noms des mangeurs (personnes qui peuvent faire les courses à la
  place du coopérateur) ;
- le numéro de coopérateur ;
- la date d'entrée effective dans la coopérative ;
- le nombre de parts ;
- la date de chacune des demandes de libération de capital ;
- une copie de chaque demande de libération de capital ;
- le certificat de coopérateur ;
- les certificats liés au Tax Shelter pour chaque année.

CoopInfoPerso doit aussi fournir une interface pour permettre aux
coopérateurs de modifier leur numéro de téléphone et leur adresse
postale.


## Conception

> **TODO**: Ajouter la partie de l'image de conception du chapitre
> coopdesk concernant CoopInfoPerso.

CoopInfoPerso regroupe un ensemble de plusieurs modules, comme expliqué
dans la section \nameref{sec:coopdesk-conception} du
chapitre \ref{sec:coopdesk} \vpageref{sec:coopdesk-conception} où se
trouve une explication du découpage de CoopInfoPerso en cinq modules.

> easy_my_coop_website_portal: expliquer où se trouve les informations à
> aller chercher. Ou alors on s'en fout un peu, car ça ne change pas
> vraiment la structure des modules.

Dans les modules *easy_my_coop_website_portal* et
*easy_my_coop_website_taxshelter*, il est question de permettre à
l'utilisateur de télécharger des PDF des différentes attestations et
certificats. Ces PDF sont décrits respectivement dans les modules
*easy_my_coop* et *easy_my_coop_taxshelter_report*. Dans Odoo ces PDF
sont appelés des *reports* (rapport en français). Un rapport est défini
dans un fichier XML. Ces PDF ne sont pas stockés sous forme de document
PDF par Odoo, mais ils sont générés à la volée à chaque fois que c'est
nécessaire. Ces deux modules devront donc pouvoir générer ces PDF à la
volée. Pour ce faire, Odoo fournit une méthode dans le module *report*.
Cette méthode met en place une URL à laquelle il faut passer certains
paramètres pour obtenir un PDF. Ces paramètres sont notamment
l'identifiant du rapport XML ainsi que l'objet qui est lié à ce rapport.
Utiliser cette méthode nécessite de modifier les droits d'accès à chaque
rapport que l'on veut fournir aux utilisateurs. En effet, par défaut,
les droits d'afficher un rapport donné, sont donnés à un groupe
d'utilisateurs, par exemple, les employés administratifs, qui seront
amenés à consulter ces rapports. Dans notre cas, il serait nécessaire de
donner un accès à tous les utilisateurs, mais uniquement sur les objets
qui les concernent, c'est-à-dire, qui sont liés à l'utilisateur qui les
consulte. Il est tout à fait possible de faire cela avec les *access
rigths* et les *ir.rules* d'Odoo. Cependant, les coopérateurs auront
accès à ces documents uniquement via une interface conçue pour cet usage
et non dans les autres modules d'Odoo. C'est pourquoi, sous les
conseils de Thibault \textsc{François}, ingénieur chez Odoo SA, il a été
décidé de ne pas donner de droits particuliers à chaque rapport, mais
d'utiliser les droits du super utilisateur d'Odoo pour accéder aux
objets nécessaires au rendu du rapport. Cela signifie que la méthode qui
se charge d'afficher les PDF devra au préalable vérifier que
l'utilisateur est bien lié au rapport qu'il demande à voir et lui
interdire l'accès le cas échéant. Cette méthode est considérée comme
plus pragmatique, car elle évite les effets de bords qui peuvent
apparaitre lorsque les droits d'accès d'Odoo sont modifiés, d'autant
qu'aucun autre module ne bénéficiera de cette modification des droits.

Le module *website_portal_extend* améliore le module
*website_portal_v10* en le rendant plus facilement extensible. Pour
rappel le module *website_portal_v10* offre une page qui affiche les
informations personnelles de l'utilisateur connecté et donne accès à un
formulaire pour modifier ces informations. Par défaut, toutes les
informations sont modifiables. L'idée est de pouvoir facilement choisir
quelles sont les informations modifiables. La BEES coop, par
exemple, souhaite que seul le numéro de téléphone et l'adresse
postale soient modifiables. C'est donc la configuration des champs
obligatoires et des champs optionnels du formulaire qu'il nous faut
modifier. Dans le module *website_portal_v10*, une seule fonction
principale se charge d'afficher et de traiter tout le formulaire. Si
l'on veut changer les champs obligatoires et optionnels, c'est donc
l'entièreté de la logique du formulaire qu'il faut réécrire. Ce que
*website_portal_extend* vient ajouter, c'est la division de la grosse
méthode de *website_portal_v10* en plus petites. De plus, les champs
obligatoires et optionnels deviennent des attributs du contrôleur. Ces
modifications permettent de facilement écrire le module
*beesdoo_website_portal* qui viendra modifier les champs obligatoires et
optionnels.


## Réalisation

> **TODO** : Prendre des captures d'écran et montrer que la réalisation
> rencontre bien le besoin.


## Difficultés et solutions

Dans le cahier des charges original, il est indiqué que le module
*easy_my_coop_website_portal* devrait fournir une interface de
configuration où les administrateurs pourraient choisir quelles 
informations personnelles peuvent être modifiées et lesquelles ne le
peuvent pas. Pour réaliser cela, il était question de faire une
introspection sur l'objet *res_partner* (objet qui représente un
utilisateur dans Odoo) afin de récupérer tous les champs qu'il contient.
Après avoir récupéré tous les champs de l'objet *res_partner*,
l'interface d'administration aurait permis de choisir quels champs
étaient modifiables. L'intérêt de cette technique est son aspect
générique. Cela permet que, si des champs sont ajoutés à l'objet
*res_partner* par d'autres modules, ils apparaissent aussi dans
l'interface de configuration.

L'introspection de l'objet *res_partner* fonctionne bien, il est aisé de
concevoir une interface pour sélectionner les champs qui doivent
apparaitre dans le formulaire de modification des informations
personnelles de l'utilisateur. Mais ce n'est pas tout, il faut
maintenant afficher ce formulaire et pouvoir valider les données qui
sont entrées par l'utilisateur. Odoo ne fournit pas de solution toute
faite pour ce genre de cas. Cependant, il est possible d'en développer
une. Une proposition d'implémentation se trouve à la
figure \vref{fig:website_portal_extend_class}. Dans cette implémentation
la classe *WebsitePartnerFormController* est le contrôleur qui se charge
de présenter le formulaire et de valider les informations
entrées par l'utilisateur, pour chaque champ dans le formulaire. Pour
présenter le formulaire, la méthode *render_form()* fait appel à toutes
les méthodes *render_nom_du_champ()* où *nom_du_champ* est le nom d'un
champ du *res_partner*. Chaque fonction *render_nom_du_champ()* se
charge de générer l'HTML nécessaire au rendu du champ visé. La même
logique est appliquée par la méthode *form_validate()*. Cette
implémentation part du principe que : qui, mieux que le développeur qui
ajoute un champ à l'objet *res_partner*, sait comment afficher ce champ
et quelles sont les validations qui doivent être effectuées sur ce champ.
C'est pourquoi, il est laissé à chaque développeur d'étendre la classe
*WebsiteParnterFormController* afin d'y ajouter les fonctions
nécessaires au rendu et la validation des champs qu'il a ajouté au
*res_partner*.

![Structure de la solution permettant d'avoir un rendu et une validation
pour tous les champs d'un *partner*.](images/website_portal_extend-class_diagram.png){#fig:website_portal_extend_class width=100%}

Après discussion avec Houssine \textsc{Bakkali}, il a été décidé de ne
pas mettre en œuvre cette solution pour se concentrer sur une solution
plus simple. En effet, le temps de développement et de test qu'il
faudrait pour réaliser cette solution dépasse le temps alloué à la
réalisation du travail de fin d'étude. De plus, cette solution fait sens
si beaucoup de clients souhaitent restreindre les champs modifiables par
leurs utilisateurs et que les champs qui peuvent être modifiés changent
régulièrement. Dans notre cas, seul la BEES coop a fait cette demande et
le choix des champs ne changera pas régulièrement. Une solution, où les
champs, qui peuvent être modifiés, sont définis dans un module, est une
solution tout à fait suffisante qui permet une certaine souplesse, sans
nécessiter beaucoup de temps de développement.
