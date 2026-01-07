-- Données de test pour le projet clAra Mobility
-- Attention : Exécuter ce fichier AVANT d'importer le CSV (pour créer les stations)

-- 1. Ajout des Stations
INSERT INTO STATION (nom, adresse, capacite) VALUES
('Gare Centrale', '1 Place de la Gare, 75000 Paris', 20),
('Place de la République', '10 Place de la République, 75003 Paris', 15),
('La Défense', '1 Parvis de la Défense, 92800 Puteaux', 30),
('Opéra', '8 Rue Scribe, 75009 Paris', 10),
('Bastille', 'Place de la Bastille, 75004 Paris', 12);

-- 2. Création des Utilisateurs (Clients et Techs)
INSERT INTO UTILISATEUR (nom, prenom, email, role, mot_de_passe) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', 'CLIENT', '123456'),
('Martin', 'Sophie', 'sophie.martin@email.com', 'CLIENT', 'password'),
('Durand', 'Pierre', 'pierre.durand@email.com', 'CLIENT', 'azerty'),
('Leroy', 'Alice', 'alice.leroy@email.com', 'CLIENT', 'alice123'),
('Bernard', 'Thomas', 'thomas.tech@clara.com', 'TECHNICIEN', 'tech01'),
('Petit', 'Julie', 'julie.tech@clara.com', 'TECHNICIEN', 'tech02');

-- 3. Quelques véhicules de test
-- J'utilise des ID > 900 pour ne pas gêner l'import CSV qui commencera à 1
INSERT INTO VEHICULE (id_vehicule, modele, type, etat, prix_heure, batterie, id_station) VALUES
(901, 'Tesla Model 3', 'Voiture', 'DISPONIBLE', 15.00, 85, 1),
(902, 'Zoe Renault', 'Voiture', 'LOUE', 9.50, 60, 2),
(903, 'Vélo Electrique', 'Velo', 'DISPONIBLE', 2.00, 100, 1),
(904, 'Scooter E-Jet', 'Scooter', 'EN_MAINTENANCE', 5.50, 10, 3);

-- 4. Historique de locations
INSERT INTO LOCATION (date_debut, date_fin, montant, id_utilisateur, id_vehicule) VALUES
('2025-12-01 10:00:00', '2025-12-01 14:00:00', 60.00, 1, 901),
('2025-12-02 09:00:00', '2025-12-02 10:00:00', 2.00, 2, 903),
('2025-12-05 18:00:00', '2025-12-06 10:00:00', 152.00, 3, 902);

-- 5. Paiements
INSERT INTO PAIEMENT (montant, date_paiement, statut, id_location) VALUES
(60.00, '2025-12-01 14:05:00', 'VALIDE', 1),
(2.00, '2025-12-02 10:05:00', 'VALIDE', 2),
(152.00, '2025-12-06 10:10:00', 'VALIDE', 3);

-- 6. Maintenances
INSERT INTO MAINTENANCE (date_intervention, type_panne, description, id_vehicule, id_technicien) VALUES
('2026-01-05', 'Batterie', 'Batterie à changer', 904, 5),
('2025-11-20', 'Pneu', 'Crevaison', 901, 6);
