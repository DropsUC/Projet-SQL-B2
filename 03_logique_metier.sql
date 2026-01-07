-- 03_logique_metier.sql
-- contient que la VUE et le TRIGGER

-- VUE
CREATE OR REPLACE VIEW vue_details_reservations AS
SELECT 
    r.id_reservation,
    u.nom || ' ' || u.prenom AS client,
    m.nom_marque || ' ' || v.modele AS voiture,
    r.date_debut,
    r.statut
FROM reservations r
JOIN utilisateurs u ON r.id_utilisateur = u.id_utilisateur
JOIN vehicules v ON r.id_vehicule = v.id_vehicule
JOIN marques m ON v.id_marque = m.id_marque;

-- TRIGGER
CREATE OR REPLACE FUNCTION verif_disponibilite() RETURNS TRIGGER AS $$
DECLARE
    etat_vehicule VARCHAR;
BEGIN
    SELECT etat INTO etat_vehicule FROM vehicules WHERE id_vehicule = NEW.id_vehicule;
    IF etat_vehicule != 'Disponible' THEN
        RAISE EXCEPTION '⛔ INTERDIT : Ce véhicule est % !', etat_vehicule;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_dispo
BEFORE INSERT ON reservations
FOR EACH ROW
EXECUTE FUNCTION verif_disponibilite();