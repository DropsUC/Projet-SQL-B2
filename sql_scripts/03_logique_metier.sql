-- 04_queries.sql
-- Mission 3 : Requêtes d'analyse (10 requêtes)

-- 1. Liste de tous les véhicules
SELECT marque, modele, etat FROM vehicule;

-- 2. Véhicules avec une autonomie > 300km
SELECT * FROM vehicule WHERE autonomie_km > 300;

-- 3. Nombre d'utilisateurs par ville
SELECT ville, COUNT(*) FROM utilisateur GROUP BY ville;

-- 4. Liste des véhicules en maintenance
SELECT id_vehicule, marque, modele FROM vehicule WHERE etat = 'En maintenance';

-- 5. Moyenne de l'autonomie par marque
SELECT marque, AVG(autonomie_km) FROM vehicule GROUP BY marque;

-- 6. Prix de location le plus élevé enregistré
SELECT MAX(montant) FROM location;

-- 7. Liste des clients ayant déjà fait une location (Jointure)
SELECT DISTINCT u.nom, u.prenom FROM utilisateur u
JOIN location l ON u.id_utilisateur = l.id_utilisateur;

-- 8. Véhicules qui n'ont jamais été loués (Sous-requête)
SELECT id_vehicule, modele FROM vehicule 
WHERE id_vehicule NOT IN (SELECT id_vehicule FROM location);

-- 9. Chiffre d'affaires total
SELECT SUM(montant) AS total_revenu FROM location;

-- 10. Nombre de véhicules par type d'énergie
SELECT energie, COUNT(*) FROM vehicule GROUP BY energie;