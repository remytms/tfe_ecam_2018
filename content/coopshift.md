# CoopShift : la gestion des *shifts* {#sec:coopshift}

Ce chapitre traite de l'application fournissant une interface pour que
le coopérateur puisse gérer son travail au sein du supermarché
coopératif.


## Le besoin

La BEES coop fonctionne sur un modèle particulier : les coopérateurs qui
veulent faire leurs courses dans le magasin doivent aussi y travailler
bénévolement 3 heures toutes les quatre semaines. Une série de règles
organise le travail des coopérateurs. 

Le travail est organisé par semaine : la semaine A, la semaine B, la
semaine C et la semaine D. Ces quatre semaines se suivent dans
l'ordre et périodiquement, c'est-à-dire, qu'une fois la semaine D
terminée, on revient à la semaine A. Chaque semaine est découpée en
créneaux. Un créneau représente une tranche horaire pendant laquelle un
certain travail doit être réalisé par un ou plusieurs travailleurs. Par
exemple, le jeudi de la semaine A de 12h à 15h, il y a un créneau
pour le travail en magasin et un créneau pour du travail administratif.
Les *shifts* représentent le travail d'un coopérateur un jour donné pour
un créneau donné. Par exemple, le *shift* de Mme X le jeudi 4 janvier
2018 de 12h à 15h dans le magasin lié au créneau du jeudi de 12h à
15h de la semaine A. Plusieurs *shifts* existent pour le même créneau à
la même date, car plusieurs travailleurs sont souvent nécessaires pour
réaliser le travail prévu par le créneau. Chaque *shift* est donc
identique si ce n'est le travailleur qui le réalise.

> **TODO**: Un petit schéma qui explique la différence entre les
> créneaux et les shifts.

Il existe trois régimes de travail différents : régulier *(regular)*,
volant *(irregular)*, exempté *(exempted)*.  Chaque travailleur doit
être inscrit à un régime de travail. Le travailleur inscrit en régime
régulier choisi de faire ses *shifts* de manière régulière au même
créneau toutes les 4 semaines. Ce travailleur est alors automatiquement
inscrit à un *shift* pendant ce créneau toutes les quatre semaines. Le
travailleur inscrit en régime volant choisi librement le *shift* auquel
il s'inscrit. Il doit cependant veiller à faire au moins l'équivalent
d'un *shift* toutes les 4 semaines.  Cependant, il lui est possible
d'anticiper des *shifts* pour prévoir une période d'indisponibilité
future. Enfin le travailleur inscrit en régime exempté est simplement
dispensé de faire des *shifts* dans le supermarché. C'est le cas
notamment des personnes âgées, des femmes enceintes, etc.

Chaque travailleur se voit attribuer un statut. Les principaux sont : à
jour *(up to date)*, en alerte *(alert)*, désincrit *(unsubscribed)*. Le
statut d'un travailleur est influencé notamment par son compteur de
*shift* qui comptabilise les présences du travailleur aux *shifts*
auxquels il s'est inscrit. C'est ce statut qui conditionne le droit de
faire ses courses dans le supermarché.

L'inscription des travailleurs volants à un *shift* se fait actuellement
par courriel. Chaque demande d'inscription est traitée une par une.
CoopShift doit permettre d'automatiser ce processus. De plus, le
travailleur doit tenir lui-même la comptabilité des *shifts* qu'il
a prestés dans le supermarché, qui est complètement déconnectée du calcul
fait par le système de gestion des *shifts*. CoopShift doit fournir un
moyen pour les travailleurs de consulter l'état de leur travail dans le
supermarché.

### Le besoin initial

CoopShift doit fournir une interface conviviale dans le but de permettre,
de manière personnelle et sécurisée, aux travailleurs :

- de consulter leur régime de travail ;
- d'avoir accès aux dates de leurs prochains *shifts* ;
- de consulter leur statut et leurs compteurs de *shifts* ;
- de consulter les créneaux disponibles (uniquement pour les
  travailleurs inscrit en régime régulier) ;
- de consulter la liste des *shifts* où il reste des places disponibles
  (uniquement pour les travailleurs inscrits en régime volants) ;
- de s'inscrire à un *shift* (uniquement pour les travailleurs inscrits
  en régime volant).


### Le besoin final

Tout au long du développement et de l'utilisation de la première version
de CoopShift, le besoin de la BEES coop s'est précisé et a évolué. À la
liste précédente s'ajoute :

- la consultation des *shifts* précédents avec leurs statuts (en attente de
  traitement, présent, absent, etc.) ;
- l'affichage de la date à laquelle le travailleur change de statut de
  « à jour » à « en alerte » (uniquement pour les travailleurs inscrit
  en régime volant) ;
- l'affichage des dates de début et de fin de congé ;
- l'affichage de texte explicatif sur la signification de chaque statut
  et de l'utilisation de CoopShift.


## Conception

L'application CoopShift est constituée d'un seul module nommé
*beesdoo_website_shift* qui se base sur le module *beesdoo_shift*. Elle
se base sur le patron de conception MVC (modèle-vue-contrôleur). Le
module *beesdoo_shift* contient entre autre la définition des modèles.
Les créneaux, les *shifts* et le statut des coopérateurs y sont définis.
*beesdoo_website_shift* se concentre sur l'aspect interface *website* et
contrôleur. L'application n'est composée que d'un seul module à l'image de
*beesdoo_shift* qui regroupe la gestion du travail des coopérateurs dans
un seul module.

Le module apporte une page web `/my/shift` qui affiche trois vues
différentes en fonction du régime de travail de l'utilisateur connecté.
Cependant, une bonne partie de ses vues ont des parties en commun. C'est
pourquoi il a été choisi de les segmenter en vues élémentaires
s'occupant chacune de l'affichage d'une information en particulier. Par
après, ces vues élémentaires sont mises ensemble pour former les trois
vues principales. Cette manière de faire évite une duplication inutile
de code et rend plus facile la recherche et la résolution de bogues.

Exemple de vue élémentaire pour l'affichage du titre de la page :

```xml
<template
  id="my_shift_title"
  name="My Shift Title">

  <div class="oe_structure"/>

  <section class="wrap">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="text-center">
            Your shifts
          </h1>
        </div>
      </div>
    </div>
  </section>

  <div class="oe_structure"/>

</template>
```

Exemple d'une vue principale qui utilise la vue élémentaire ci-dessus :

```xml
<template
  id="my_shift_exempted_worker"
  name="My Shifts for Exempted Workers"
  page="True">
  <t t-call="website.layout">

    <t t-call="beesdoo_website_shift.my_shift_title"/>

    . . .

  </t>
</template>
```

Du côté du contrôleur la même logique a été suivie. Une première méthode
accessible via la page `/my/shift` va rendre la vue adéquate et appeler
la méthode liée à cette vue. C'est cette dernière qui se chargera de
préparer les valeurs qui seront affichées par la vue.

```python
@http.route('/my/shift', auth='user', website=True)
def my_shift(self, **kw):
    """
    Personal page for managing your shifts
    """
    if self.is_user_irregular():
        return request.render(
            'beesdoo_website_shift.my_shift_irregular_worker',
            self.my_shift_irregular_worker(nexturl='/my/shift')
        )
    if self.is_user_regular():
        return request.render(
            'beesdoo_website_shift.my_shift_regular_worker',
            self.my_shift_regular_worker()
        )
    if self.is_user_exempted():
        return request.render(
            'beesdoo_website_shift.my_shift_exempted_worker',
            self.my_shift_exempted_worker()
        )

        return request.render(
            'beesdoo_website_shift.my_shift_non_worker',
            {}
        )
```

À chaque vue, élémentaire ou principale, correspond une méthode dans le
contrôleur. Les méthodes pour les vues principales font appel aux
méthodes des vues élémentaires comme on peut le voir dans la méthode
suivante avec les appels à `self.my_shift_worker_status()`,
`self.my_shift_next_shifts()`, etc.

```python
def my_shift_regular_worker(self):
    """
    Return template variables for 
    'beesdoo_website_shift.my_shift_regular_worker' template
    """
    # Create template context
    template_context = {}

    # Get all the task template
    template = request.env['beesdoo.shift.template']
    task_templates = template.sudo().search(
        [], 
        order="planning_id, day_nb_id, start_time"
    )

    template_context.update(
        self.my_shift_worker_status()
    )
    template_context.update(
        self.my_shift_next_shifts()
    )
    template_context.update(
        self.my_shift_past_shifts()
    )
    template_context.update(
        {
            'task_templates': task_templates,
            'float_to_time': float_to_time,
        }
    )
    return template_context
```

> Parler de la construction des shifts fictifs ?


## Réalisation

> Présenter la réalisation en images et montrer qu'elle correspond bien au
> besoin (ou pas).


## Difficultés et solutions

Un des aspects du besoin qui a été sous-estimé lors de la conception est
l'affichage des *shifts* futures pour un travailleur en régime
irrégulier. Pour comprendre pourquoi, il faut s'atteler à analyser le
fonctionnement actuel de l'outil de gestion des *shifts*. 

Il y a quatre semaines différentes (semaines A, B, C et D). Le système
contient au plus quatre semaines de *shifts* dans le futur. Chaque fois
qu'une semaine se termine, la même semaine (A, B, C ou D) est à nouveau
générée. Par exemple, si la semaine A commence le 1 janvier et se
termine le 7 janvier, alors le 7 janvier le système génèrera la
prochaine semaine A qui se tiendra trois semaines plus tard, donc du 29
janvier au 4 février. Généré une semaine signifie que le système va
convertir les créneaux de la semaine en question en *shifts*. Ce sont
ces *shifts* qui sont utilent pour l'affichage des informations dans
CoopShift.

La solution initiale pour afficher la liste des *shifts* futures d'un
travailleur était de simplement lister les *shifts* futures existant en
base de donnée auxquels le travailleur est inscrit. Cela fonctionne très
bien pour les travailleurs en régime volant, mais pas pour les
travailleurs en régime régulier. En effet ces derniers ne voyaient qu'un
seul prochain *shift*, voir aucun juste après avoir effectué leur
*shift* car la nouvelle semaine qui correspond à leur créneau n'a pas
encore été générée par le système. Étant donné qu'il fallait afficher
les 13 prochains *shifts* pour un travailleur en régime régulier, il
fallait donc générer des *shifts* fictifs. L'adjectif « fictif » est
utilisé pour désigner fait que ces *shifts* futurs ne seront pas
enregistrés en base de donnée pour ne pas perturber système de
génération. Ils seront simplement calculés pour l'affichage.

Cette solution de générer des *shifts* fictifs comporte encore une
limitation. Il faudrait en effet tenir compte des jours fériés pendant
lesquels il n'y a pas de travail dans le supermarché. Pendant les jours
fériés, les travailleurs ne doivent pas venir faire leur *shift*. Il
faudrait donc, qu'un *shift* fictif qui tombe pendant un jour férié ne
soit pas affiché, car il ne devra pas être fait par le travailleur. Afin
de dépasser cette limitation, la solution proposée est de fournir une
interface pour encoder, à l'avance, les jours fériés pour les années à
venir. Cette une solution globale qui permettrait au système qui génère
les *shifts* de, lui aussi, tenir compte des jours fériés. Pour
l'instant, les *shifts* qui tombent pendant un jour férié sont supprimés
à la main après leur génération.

Un petit détail restait à régler pour l'affichage des *shifts* fictifs.
Les heures de début et de fin de *shift* étaient décalées d'une heure
après les dates de changement d'heure légale. La génération se passe
comme suit :

1. Un *shift* existant appartenant au créneau horaire du travailleur est
   récupéré dans la base de donnée.
1. Une copie de ce *shift* est réalisée et constitue un *shift* fictif.
1. Un multiple de 24 jours (l'équivalent en jour de quatre semaines) est
   ajouté aux dates de début et de fin du *shift* fictif.

Toutes les dates, enregistrées dans la base de donnée et stockée dans les
objets, sont enregistrées comme étant des dates UTC (temps universel
coordonné). L'UTC ne connait pas de changement d'heure d'été et d'hiver.
Il permet d'être une référence commune pour toutes les heures du globe.
C'est lors de l'affichage d'une date que celle-ci est transformée en
heure locale en utilisant le fuseau horaire défini dans les paramètres
d'Odoo ou de l'utilisateur. La première réalisation ajoutait simplement
les jours en plus à l'heure UTC ce qui impliquait un décalage des heures
de début et de fin de *shift* aux passages entre l'heure d'été et l'heure
d'hiver. En effet, à l'heure d'hiver belge, un *shift* qui commence à
12h, heure légale belge, se passe à en réalité à 11h, heure UTC. Le même
*shift* réalisé, à l'heure d'été belge, qui commence toujours à 12h,
heure légale belge, se passe à 10h, heure UTC. Cela est dû au fait qu'en
hiver l'heure légale belge est UTC+1 et en été l'heure légale belge est
UTC+2. Il faut donc que l'ajout des jours tienne compte de ce changement
d'heure afin de le répercuter l'heure UTC stockée dans le *shift*.
L'ajout des jours se fait via la méthode `timedelta()` du module
`datetime` de Python. Pour comprendre le problème, il faut comprendre
comment Python gère les dates et les heures. Il y a deux types de date
différentes : les dates brutes qui ne sont liées à aucun fuseau horaire
appelée *naïves* et les dates qui sont liées à un fuseau horaire appelée
*non-naïves*. Lorsqu'on ajoute un décalage de jours à une date
non-naïve, le fuseau horaire est laissé intacte. Une date, avant le
changement d'heure, qui est liée au fuseau horaire UTC+1, après l'ajout
d'un nombre de jour qui la fait passer à une date après le changement
d'heure, conserve le fuseau horaire UTC+1 là où elle devrait se voir
attribué le fuseau horaire UTC+2. La solution est donc de corriger le
fuseau horaire une fois la date modifiée afin que la conversion vers
l'heure UTC répercute bien le changement d'heure. 
