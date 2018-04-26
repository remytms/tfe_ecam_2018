# CoopReceipt : la gestion des tickets de caisses {#sec:coopreceipt}

Ce chapitre traite de l'application CoopReceipt qui se charge de mettre
à disposition du coopérateur, dans son espace personnel, les tickets de
caisses des achats qu'il a effectués dans le supermarché.


## Le besoin

La BEES coop est aussi un supermarché. Les coopérateurs qui travaillent
dans le magasin peuvent avoir la qualité de client du supermarché. Ils
effectuent donc des courses régulièrement.

Dans un souci d'écologie, la BEES coop n'imprime pas automatiquement
les tickets de caisse. Mais elle propose actuellement aux coopérateurs
de leur envoyer par courriel. Cependant, il arrive qu'un courriel se
perde ou finisse dans les courriels indésirables ou encore que le
coopérateur supprime le courriel contenant un ticket de caisse par
mégarde. Il n'a alors pas de moyen simple, pour lui, de retrouver le
ticket de caisse perdu. La BEES coop souhaite que les coopérateurs
puissent retrouver l'historique de leurs achats passés dans le
supermarché via l'accès à leurs tickets de caisses dans l'interface
*website*.

CoopReceipt doit donc fournir une interface *website* qui permet aux
coopérateurs d'accéder à l'historique de leurs tickets de caisse et de
pouvoir consulter chacun d'eux.


## Conception

Les commandes d'un point de vente sont stockée dans Odoo via l'objet
*pos.order*. Cet objet contient toutes les informations liées à la
commande : le numéro de la commande, le client, le détail des achats,
la caisse qui a servi à la vente, la méthode de payement, etc. Le ticket
de caisse doit quant à lui être généré à la volée à l'instar de ce qui
se fait dans CoopInfoPerso. C'est donc la même logique qui va être
suivie. À savoir, une vérification des autorisations de l'utilisateur à
visionner le ticket de caisse demandé (le ticket de caisse ne sera
accessible que si l'utilisateur est le même que le client renseigné sur
le ticket de caisse), ensuite un accès avec les droits du
super-utilisateur d'Odoo pour récupérer la commande en question et
générer le ticket de caisse, et pour finir l'affichage du ticket sous
format PDF à l'utilisateur.


## Réalisation

> **TODO** : Les captures d'écran de CoopReceipt.
