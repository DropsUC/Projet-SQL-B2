-- 02_donnees_exemples.sql
-- Données exemples pour montrer comment on remplit
-- contient que les INSERT INTO

INSERT INTO marques (nom_marque) VALUES ('Tesla'), ('Renault'), ('Peugeot');
INSERT INTO energies (nom_energie) VALUES ('Electrique');

INSERT INTO utilisateurs (nom, prenom, email, ville, date_inscription) VALUES
('Dupont', 'Marie', 'marie.dupont@email.com', 'Paris', '2024-01-15'),
('Martin', 'Lucas', 'lucas.martin@email.com', 'Lyon', '2024-02-20');


-- les 200 véhicules sont dans le fichier CSV
