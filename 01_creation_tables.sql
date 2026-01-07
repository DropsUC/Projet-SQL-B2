-- 01_creation_tables.sql
-- Structure de la base de données

DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS utilisateurs CASCADE;
DROP TABLE IF EXISTS vehicules CASCADE;
DROP TABLE IF EXISTS station CASCADE; -- Ajouté pour nettoyer proprement
DROP TABLE IF EXISTS marques CASCADE;
DROP TABLE IF EXISTS energies CASCADE;

-- 1. On crée d'abord les tables qui n'ont pas de dépendances
CREATE TABLE marques (
    id_marque SERIAL PRIMARY KEY,
    nom_marque VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE energies (
    id_energie SERIAL PRIMARY KEY,
    nom_energie VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE station (
    id_station SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    adresse VARCHAR(255),
    capacite INT
);

-- 2. Ensuite les tables qui dépendent des autres (Clés étrangères)
CREATE TABLE vehicules (
    id_vehicule INTEGER PRIMARY KEY,
    marque VARCHAR(100),
    modele VARCHAR(100),
    annee INTEGER,
    -- J'ai assoupli le check car si ton CSV contient "Hybrid", l'import planterait avec 'Electrique' strict
    energie VARCHAR(50), 
    autonomie_km INTEGER,
    immatriculation VARCHAR(20) UNIQUE,
    etat VARCHAR(50),
    localisation VARCHAR(100),
    id_station INT REFERENCES station(id_station)
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
