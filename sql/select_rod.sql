select stations.*, count(velos_disponibles.id_velo)
from 
    (
    select *
    from velos
    where niveau_de_charge_baterie > 50 and etat = 'disponible'
    ) velos_disponibles natural join stations
group by stations.id_station
having count(velos_disponibles.id_velo) > 2
order by stations.id_station;

select velos.id_velo, velos.marque, velos.modele, velos.dt_mise_en_service, velos.etat, emprunts.dt_departure, emprunts.id_station_depart, stations.nom, stations.coordones_gps, stations.capacite, stations.id_adresse 
from emprunts natural join velos inner join stations on emprunts.id_station_depart = stations.id_station
where velos.etat = 'en emprunt';

select emprunt.*, station_arrive.nom as station_arrive_nom, station_arrive.coordones_gps as station_arrive_coordones_gps, station_arrive.capacite as station_arrive_capacite, station_arrive.id_adresse as station_arrive_id_adresse,station_depart.nom as station_depart_nom, station_depart.coordones_gps as station_depart_coordones_gps, station_depart.capacite as station_depart_capacite, station_depart.id_adresse as station_depart_id_adresse
from emprunts emprunt inner join stations station_arrive on emprunt.id_station_arrive = station_arrive.id_station inner join stations station_depart on emprunt.id_station_depart = station_depart.id_station
where emprunt.id_adherent = 1;


--TODO 6 Update 5 and 6 to include the hour when its implemented