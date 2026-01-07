### 1. Dictionnaire des Données

Ce tableau recense toutes les informations réellement implémentées dans la base de données PostgreSQL.

| Table | Code | Libellé | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| **UTILISATEURS** | `id_utilisateur` | Identifiant | Serial (PK) | Clé unique auto-incrémentée |
| | `nom` | Nom | Varchar | Nom de famille |
| | `prenom` | Prénom | Varchar | Prénom de l'utilisateur |
| | `email` | Email | Varchar | Unique (contact et identification) |
| | `ville` | Ville | Varchar | Lieu de résidence |
| | `date_inscription`| Date Inscription| Date | Date de création du compte |
| **VEHICULES** | `id_vehicule` | Identifiant | Integer (PK)| Identifiant unique du véhicule |
| | `modele` | Modèle | Varchar | Ex: 'Zoe', 'Model 3' |
| | `immatriculation`| Immatriculation | Varchar | Unique (Plaque minéralogique) |
| | `autonomie_km` | Autonomie | Integer | Portée maximale en km |
| | `etat` | État | Varchar | 'Disponible', 'En maintenance', 'Hors service' |
| | `localisation` | Localisation | Varchar | Ville où est stationné le véhicule |
| | `id_marque` | Réf. Marque | Integer (FK)| Lien vers la table Marques |
| | `id_energie` | Réf. Énergie | Integer (FK)| Lien vers la table Énergies |
| **RESERVATIONS** | `id_reservation` | Identifiant | Serial (PK) | Numéro de la réservation |
| | `date_debut` | Date Début | Timestamp | Date et heure de départ |
| | `date_fin` | Date Fin | Timestamp | Date et heure de retour |
| | `statut` | Statut | Varchar | 'En cours', 'Terminée', 'Annulée' |
| | `cout_total` | Coût | Numeric | Montant facturé au client |
| | `id_utilisateur` | Réf. Client | Integer (FK)| Qui a loué le véhicule |
| | `id_vehicule` | Réf. Véhicule | Integer (FK)| Quel véhicule est loué |
| **MARQUES** | `id_marque` | Identifiant | Serial (PK) | Identifiant technique |
| | `nom_marque` | Marque | Varchar | Ex: 'Renault', 'Tesla' |
| **ENERGIES** | `id_energie` | Identifiant | Serial (PK) | Identifiant technique |
| | `nom_energie` | Énergie | Varchar | Ex: 'Electrique' |

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
