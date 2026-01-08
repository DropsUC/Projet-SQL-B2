-- Données de test pour le projet clAra Mobility
-- Attention : Exécuter ce fichier AVANT d'importer le CSV (pour créer les stations)


-- 1 Répartition des véhicules par état (Disponible ou Maintenance).

SELECT etat, COUNT(*) AS nombre 
FROM vehicules 
GROUP BY etat;

-- 2 Nombre de disponibilité par ville.

SELECT localisation, COUNT(*) AS nb_vehicules
FROM vehicules
WHERE etat = 'Disponible'
GROUP BY localisation
ORDER BY nb_vehicules DESC;

-- 3 Calcul de l'autonomie moyenne par marque.

SELECT marque, ROUND(AVG(autonomie_km), 2) AS autonomie_moyenne 
FROM vehicules 
GROUP BY marque 
HAVING AVG(autonomie_km) > 300;

-- 4 Trouver les véhicules dont l'autonomie est supérieure à l'autonomie moyenne globale.

SELECT marque, modele, immatriculation, autonomie_km
FROM vehicules
WHERE autonomie_km > (SELECT AVG(autonomie_km) FROM vehicules);

-- 5 Identifier les véhicules "Hors service" par ville

CREATE VIEW vue_maintenance_prioritaire AS
SELECT localisation, marque, modele, immatriculation
FROM vehicules
WHERE etat = 'Hors service';

-- 6 Analyse de la Rentabilité par Ville.

CREATE VIEW vue_rentabilite_localisation AS
SELECT 
    v.localisation, 
    COUNT(r.id_reservation) AS nb_locations, 
    SUM(r.cout_total) AS chiffre_affaires_total
FROM vehicules v
JOIN reservations r ON v.id_vehicule = r.id_vehicule
GROUP BY v.localisation
ORDER BY chiffre_affaires_total DESC;

-- 7 Changer l'état du véhicule lors d'une réservation.

CREATE OR REPLACE FUNCTION update_etat_vehicule() 
RETURNS TRIGGER AS $$
BEGIN
    UPDATE vehicules SET etat = 'Indisponible' 
    WHERE id_vehicule = NEW.id_vehicule;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_apres_reservation
AFTER INSERT ON reservations
FOR EACH ROW 
EXECUTE FUNCTION update_etat_vehicule();

-- TEST : 
INSERT INTO public.utilisateurs (id_utilisateur, nom, prenom, email, ville, date_inscription)
VALUES (1, 'NomTest', 'PrenomTest', 'test@clara.fr', 'Paris', CURRENT_DATE);

-- ENSUITE :
INSERT INTO public.reservations (date_debut, date_fin, id_utilisateur, id_vehicule, cout_total)
VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '2 hours', 1, 8, 40.00);
SELECT id_vehicule, modele, etat FROM vehicules WHERE id_vehicule = 8;

-- 8 Historique du changement d'état.

CREATE TABLE historique_etats (
    id_log SERIAL PRIMARY KEY,
    id_vehicule INT,
    ancien_etat VARCHAR(50),
    nouvel_etat VARCHAR(50),
    date_changement TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE FUNCTION log_changement_etat() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.etat <> NEW.etat THEN
        INSERT INTO historique_etats (id_vehicule, ancien_etat, nouvel_etat)
        VALUES (OLD.id_vehicule, OLD.etat, NEW.etat);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_etat
AFTER UPDATE ON vehicules
FOR EACH ROW EXECUTE FUNCTION log_changement_etat();

-- 9 Estimer le coût d'une location.

CREATE OR REPLACE FUNCTION calculer_cout_location(debut TIMESTAMP, fin TIMESTAMP)
RETURNS DECIMAL AS $$
DECLARE
    nb_jours INTEGER;
BEGIN
    nb_jours := EXTRACT(DAY FROM (fin - debut)) + 1;
    RETURN nb_jours * 40.00;
END;
$$ LANGUAGE plpgsql;
-- TEST : 
-- SELECT calculer_cout_location('2025-01-01 10:00:00', '2025-01-03 10:00:00') AS prix_test;

-- 10 

CREATE OR REPLACE FUNCTION calculer_autonomie_restante(v_id INT, pourcentage_batterie INT) 
RETURNS FLOAT AS $$
DECLARE
    autonomie_max INT;
BEGIN
    SELECT autonomie_km INTO autonomie_max FROM vehicules WHERE id_vehicule = v_id;
    RETURN (autonomie_max * pourcentage_batterie) / 100.0;
END;
$$ LANGUAGE plpgsql;

-- TEST : 
SELECT marque, modele, autonomie_km, calculer_autonomie_restante(10, 60) AS km_restants
FROM vehicules
WHERE id_vehicule = 10;




