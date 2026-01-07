# Projet B2 : Base de données clAra Mobility 🚗

Voici mon rendu pour le projet SQL.
Le but était de créer une base de données pour gérer une flotte de voitures électriques (utilisateurs, locations, état des voitures...).

## Ce que contient le projet
* **Les données :** J'ai importé environ 200 véhicules (avec immatriculation, autonomie, ville...).
* **La structure :** J'ai utilisé la méthode Merise pour séparer les données proprement (tables Marques, Énergies, etc.).
* **Sécurité (Trigger) :** J'ai codé une protection automatique qui empêche de réserver une voiture si elle est notée "En maintenance" ou "Hors service".
* **Simplification (Vue) :** Une vue SQL permet de lire les réservations avec les noms des clients au lieu des numéros.

## Les fichiers du dépôt
* `projet_clara_final.sql` : C'est le fichier complet (généré par pgAdmin). Il contient **toutes les données** et permet de restaurer la base entièrement.
* `source_code_lisible.sql` : Une version épurée et commentée de mon code, pour mieux comprendre la structure et les triggers sans tout le blabla technique.

## Comment tester ?
Il suffit de restaurer le fichier `projet_clara_final.sql` dans une base de données vide sur PostgreSQL.
