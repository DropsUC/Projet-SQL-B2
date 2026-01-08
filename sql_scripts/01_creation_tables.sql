-- 01_creation_tables.sql
-- Structure de la base de données clAra Mobility

DROP TABLE IF EXISTS maintenance, paiement, location, vehicule, utilisateur, station CASCADE;

-- Tables de base

CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    role VARCHAR(50),
    ville VARCHAR(100)
);

-- Table alignée sur ton fichier CSV
CREATE TABLE vehicule (
    id_vehicule INTEGER PRIMARY KEY,
    marque VARCHAR(100),
    modele VARCHAR(100),
    annee INTEGER,
    energie VARCHAR(50),
    autonomie_km INTEGER,
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(50),
    localisation VARCHAR(100)
);

-- Tables de suivi
CREATE TABLE location (
    id_location SERIAL PRIMARY KEY,
    date_debut TIMESTAMP,
    date_fin TIMESTAMP,
    montant DECIMAL(10, 2),
    id_utilisateur INTEGER REFERENCES utilisateur(id_utilisateur),
    id_vehicule INTEGER REFERENCES vehicule(id_vehicule)
);

CREATE TABLE paiement (
    id_paiement SERIAL PRIMARY KEY,
    montant DECIMAL(10, 2),
    date_paiement TIMESTAMP,
    statut VARCHAR(50),
    id_location INTEGER REFERENCES location(id_location)
);

CREATE TABLE maintenance (
    id_maintenance SERIAL PRIMARY KEY,
    date_intervention DATE,
    type_panne VARCHAR(100),
    description TEXT,
    id_vehicule INTEGER REFERENCES vehicule(id_vehicule),
    id_technicien INTEGER REFERENCES utilisateur(id_utilisateur)
);
