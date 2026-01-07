# 📘 Dossier d'Analyse (Méthode Merise)

Ce document détaille la conception de la base de données **clAra Mobility**.

---

## 1. Dictionnaire des Données
Ce tableau recense toutes les informations stockées dans le système.

| Code | Libellé | Type | Contrainte |
| :--- | :--- | :--- | :--- |
| **id_vehicule** | Identifiant unique du véhicule | Entier | PRIMARY KEY |
| **immatriculation** | Plaque d'immatriculation | Varchar(20) | UNIQUE |
| **modele** | Modèle commercial | Varchar(100) | - |
| **annee** | Année de mise en service | Entier | - |
| **autonomie_km** | Autonomie batterie | Entier | - |
| **etat** | État (Disponible, Panne...) | Varchar(50) | - |
| **id_marque** | Référence à la marque | Entier | FOREIGN KEY |
| **id_energie** | Référence à l'énergie | Entier | FOREIGN KEY |
| **id_utilisateur** | Identifiant unique du client | Entier | PRIMARY KEY |
| **nom** | Nom de famille | Varchar(100) | - |
| **prenom** | Prénom | Varchar(100) | - |
| **email** | Adresse email client | Varchar(150) | UNIQUE |
| **date_debut** | Début de la location | Timestamp | - |
| **date_fin** | Fin de la location | Timestamp | - |
| **cout_total** | Montant facturé | Decimal | - |

---

## 2. Modèle Logique de Données (MLD)
Traduction des entités en tables relationnelles.
*(Légende : <u>Souligné</u> = Clé Primaire, # = Clé Étrangère)*

> **MARQUE** (<u>id_marque</u>, nom_marque)
>
> **ENERGIE** (<u>id_energie</u>, nom_energie)
>
> **UTILISATEUR** (<u>id_utilisateur</u>, nom, prenom, email, ville, date_inscription)
>
> **VEHICULE** (<u>id_vehicule</u>, modele, annee, autonomie_km, immatriculation, etat, localisation, #id_marque, #id_energie)
>
> **RESERVATION** (<u>id_reservation</u>, date_debut, date_fin, statut, cout_total, #id_utilisateur, #id_vehicule)

---

## 3. Modèle Conceptuel de Données (MCD)
Représentation graphique des relations entre les entités.

```mermaid
erDiagram
    UTILISATEUR ||--o{ RESERVATION : "Effectue"
    VEHICULE ||--o{ RESERVATION : "Concerne"
    MARQUE ||--|{ VEHICULE : "Construit"
    ENERGIE ||--|{ VEHICULE : "Alimente"

    UTILISATEUR {
        int id_utilisateur PK
        string nom
        string email
    }

    VEHICULE {
        int id_vehicule PK
        string immatriculation
        string etat
        int id_marque FK
    }

    RESERVATION {
        int id_reservation PK
        datetime date_debut
        datetime date_fin
        int id_utilisateur FK
        int id_vehicule FK
    }
