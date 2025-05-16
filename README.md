# BookingBDD - Système de Réservation de Logements

Une application Ruby on Rails permettant la gestion de réservations de logements, similaire à un service de location de courte durée.
Nous nous intéressons ici à la partie des `models` et des `migrations`.

## Fonctionnalités

* Gestion des utilisateurs
* Gestion des logements
* Système de réservation avec validation des disponibilités
* Données de test générées automatiquement

## Modèles de données

L'application est structurée autour de quatre modèles principaux :

* **User** : Utilisateurs pouvant proposer des logements ou effectuer des réservations
* **City** : Villes où se situent les logements
* **Accomodation** : Logements disponibles à la location
* **Booking** : Réservations effectuées par les utilisateurs

## Prérequis

* Ruby 3.2+
* Rails 8.0.2
* PostgreSQL

## Installation

1. Cloner le dépôt
```bash
git clone [url-du-repo]
cd BookingBDD
```

2. Installer les dépendances
```bash
bundle install
```

3. Configurer la base de données
```bash
rails db:create
rails db:migrate
```

4. Générer les données de test
```bash
rails db:seed
```

5. Lancer le serveur
```bash
rails server
```

## Validations

Le système implémente plusieurs validations :
* Validation du format des emails et numéros de téléphone
* Vérification des chevauchements de réservations
* Impossibilité de réserver son propre logement
* Validation des dates de réservation

## Technologies utilisées

* Ruby on Rails 8.0.2
* PostgreSQL
* Turbo & Stimulus
* Faker (pour les données de test)

## Développement

Pour ajouter de nouvelles fonctionnalités ou corriger des bugs :

1. Créer une branche pour votre fonctionnalité
2. Développer et tester votre code
3. Soumettre une pull request

## Tests

Exécuter les tests avec :
```bash
rails test
```

## Auteurs
- [THIAM](https://github.com/thaliou)
- [ASSY](https://github.com/AssyaJalo)
- [SOUARE](https://github.com/bbkouty)
- [FANAR](https://github.com/fanarbandia)
- [MAIGA](https://github.com/Fadelion)

## Licence

Ce projet est sous licence MIT. Consultez le fichier [LICENSE](LICENSE) pour plus de détails.

---
Développé dans le cadre d'un projet d'apprentissage de la programmation web avec Ruby on Rails
