
-- ============================================================
--   Consultation 7:
--   List of clients having borrowed at least 2 bikes in a same
--   day
-- ============================================================
SELECT DISTINCT id_adherent, nom_adherent, prenom
FROM adherents
    NATURAL JOIN emprunts
WHERE dt_depart = dt_arrive
GROUP BY id_adherent, nom_adherent, prenom, id_velo, dt_depart
HAVING count(*) >= 2
;

-- ============================================================
--   Consultation 8:
--   List of bikes never borrowed
-- ============================================================
SELECT id_velo
FROM velos
EXCEPT
SELECT id_velo
FROM velos
    NATURAL JOIN emprunts
;

-- ============================================================
--   Consultation 9:
--   List of bikes in maintenance with information of the last
--   intervention
-- ============================================================
SELECT id_velo, dt_intervention, nature_intervention, duree_intervention 
FROM velos
    NATURAL JOIN historique_maintenances
WHERE etat = 'en maintenance'
    AND dt_intervention = (
        SELECT MAX(dt_intervention)
        FROM historique_maintenances h
        WHERE h.id_velo = velos.id_velo
    )
;
