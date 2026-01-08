-- 01_creation_tables.sql
-- Structure de la base de données
-- contient les CREATE TABLE

DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS utilisateurs CASCADE;
DROP TABLE IF EXISTS vehicules CASCADE;
DROP TABLE IF EXISTS energies CASCADE;

CREATE TABLE energies (
    id_energie SERIAL PRIMARY KEY,
    nom_energie VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE vehicules (
    id_vehicule INTEGER PRIMARY KEY,
    marque VARCHAR(100),
    modele VARCHAR(100),
    annee INTEGER,
    energie VARCHAR(20),
    autonomie_km INT CHECK (autonomie_km > 0),
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(50),
    localisation VARCHAR(100)
);

CREATE TABLE utilisateurs (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    ville VARCHAR(100),
    date_inscription DATE
);

CREATE TABLE reservations (
    id_reservation SERIAL PRIMARY KEY,
    date_debut TIMESTAMP,
    date_fin TIMESTAMP,
    statut VARCHAR(50) DEFAULT 'Terminée',
    cout_total DECIMAL(10, 2),
    id_utilisateur INTEGER REFERENCES utilisateurs(id_utilisateur),
    id_vehicule INTEGER REFERENCES vehicules(id_vehicule)
);

CREATE TABLE clients (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    date_inscription DATE DEFAULT CURRENT_DATE
);
