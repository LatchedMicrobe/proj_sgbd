-- Liste des stations situées dans une commune donnée, avec leur capacité, le nombre de vélos
-- (Paris)
SELECT s.id_station, s.nom_station, s.capacite, COUNT(v.id_velo) AS nombre_velos, (s.capacite - COUNT(v.id_velo)) AS nombre_places_disponibles
FROM stations s 
JOIN adresses a ON s.id_adresse = a.id_adresse
LEFT JOIN velos v ON s.id_station = v.id_station
WHERE a.commune = 'Paris'
GROUP BY s.id_station;


-- Liste des vélos disponibles dans une station donnée, classés par niveau de charge décroissant.
-- (station 2)
SELECT v
FROM velos v
WHERE v.id_station = 2
ORDER BY v.niveau_de_charge_baterie DESC;


-- Liste des stations disposant d’au moins deux vélos disponibles dont le niveau de batterie est supérieur à 50
SELECT s.*
FROM stations s
WHERE 2 <= (
            SELECT COUNT(v.id_velo)
            FROM velos v
            WHERE niveau_de_charge_baterie > 50 AND v.id_station = s.id_station AND v.etat = 'disponible'
           );