# Projet SQL : Clara Mobility 🚘⚡


## À propos du projet
Voici mon rendu pour le projet de base de données. L'objectif était de créer un système pour gérer une flotte de voitures électriques (clients, locations, pannes...).

J'ai importé les 200 véhicules du fichier CSV fourni et j'ai ajouté toute la logique de gestion derrière (clients, réservations, sécurité).

---

## 📂 Comment j'ai organisé mes fichiers
Pour que ce soit plus simple à corriger, j'ai découpé mon code en plusieurs parties :

* **`01_creation_tables.sql`** : C'est le squelette de la base. J'y crée les tables vides (Véhicules, Marques, Clients...) avec les bonnes clés primaires et étrangères.
* **`02_donnees_demo.sql`** : Quelques lignes d'exemple pour montrer comment on remplit les tables manuellement.
* **`03_logique_metier.sql`** : C'est ici qu'il y a les **bonus**. J'ai créé une Vue pour simplifier les factures et un **Trigger** qui empêche de réserver une voiture si elle est en panne.
* **`projet_clara_final.sql`** : **Le fichier complet** (Backup). Il contient tout (les 200 voitures + la structure). C'est celui-là qu'il faut utiliser pour restaurer la base.

---

## 🧠 Partie Analyse (Merise)

Voici les informations demandées pour la modélisation.

### 1. Dictionnaire des données
Voici les infos principales que je stocke :

| Donnée | Type | Info |
| :--- | :--- | :--- |
| **id_vehicule** | Entier | Identifiant unique |
| **immatriculation** | Texte | Unique (ex: AB-123-CD) |
| **autonomie** | Entier | En kilomètres |
| **etat** | Texte | ex: "Disponible", "En maintenance" |
| **email_client** | Texte | Unique pour chaque client |
| **date_reservation** | Date/Heure | Début de la location |

### 2. Mon Modèle Logique (MLD)
J'ai sorti les marques et les énergies dans des tables à part pour éviter les répétitions.

* **MARQUE** (<u>id_marque</u>, nom_marque)
* **ENERGIE** (<u>id_energie</u>, nom_energie)
* **VEHICULE** (<u>id_vehicule</u>, modele, immat, etat, #id_marque, #id_energie)
* **CLIENT** (<u>id_client</u>, nom, prenom, email, ville)
* **RESERVATION** (<u>id_reservation</u>, date_debut, date_fin, #id_client, #id_vehicule)

### 3. Schéma (MCD)
J'ai généré le schéma visuel directement avec l'outil de pgAdmin (ERD) pour être sûr qu'il corresponde exactement à mon code.

---

## 🛠️ Comment tester mon projet ?
Le plus simple pour vous est de :
1. Télécharger le fichier `projet_clara_final.sql`.
2. Créer une base vide dans pgAdmin.
3. Faire un clic-droit > **Restore** et choisir mon fichier.

Tout devrait s'installer (tables + les 200 voitures + le trigger).
