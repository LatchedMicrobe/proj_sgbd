-- 1. Utilisation des vélos : pour chaque vélo, le nombre total d’emprunts et le nombre d’adhérents distincts l’ayant utilisé au cours des trente derniers jours.
-- para cada bicicleta, informe o número total de empréstimos e o número de associados distintos que a utilizaram nos últimos 30 dias.


SELECT B.*,
       COUNT(id_emprunt) AS numero_total_emprunts,
       COUNT(DISTINCT E.id_adherent) AS numero_adherents
FROM velos B LEFT JOIN emprunts E
ON B.id_velo = E.id_velo
WHERE E.dt_depart BETWEEN CURRENT_DATE - 30 AND CURRENT_DATE
GROUP BY B.id_velo;


-- 2. Distances parcourues : pour chaque vélo, la distance totale et la distance moyenne parcourues au cours d’une semaine donnée.
-- 2. Distâncias percorridas: para cada bicicleta, informe a distância total e a distância média percorridas em uma determinada semana.

SELECT B.*,
       SUM(e.distance_parcourue) AS distance_totale,
       AVG(E.distance_parcourue) AS distance_moyenne
FROM velos B LEFT JOIN emprunts E
ON B.id_velo = E.id_velo 
AND E.dt_depart >= DATE '2026-11-16' 
AND E.dt_depart <= DATE '2026-11-22'
GROUP BY B.id_velo
ORDER BY B.id_velo ASC;

-- 3. Vélos fortement utilisés : la liste des vélos ayant effectué au moins dix trajets au cours des trente derniers jours, classés par nombre décroissant de trajets.
-- Bicicletas com uso intenso — Liste as bicicletas que fizeram pelo menos dez trajetos nos últimos 30 dias, em ordem decrescente pelo número de trajetos.

SELECT B.*,
       COUNT(E.id_emprunt) AS numero_trajets
FROM velos B JOIN emprunts E
ON B.id_velo = E.id_velo
WHERE E.dt_depart BETWEEN CURRENT_DATE - 30 AND CURRENT_DATE
GROUP BY B.id_velo
HAVING COUNT(E.id_emprunt) >= 10
ORDER BY numero_trajets DESC;