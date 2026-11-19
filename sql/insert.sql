-- Donnees fictives pour Flotte de Velos (PostgreSQL + PostGIS).
-- Executer create.sql avant ce fichier.
-- Ce script ajoute un jeu de donnees sans supprimer les enregistrements existants.
-- Attention : une nouvelle execution peut creer des doublons logiques.

BEGIN;

DO $$
DECLARE
    stations_ids INTEGER[] := ARRAY[]::INTEGER[];
    adherents_ids INTEGER[] := ARRAY[]::INTEGER[];
    velos_ids INTEGER[] := ARRAY[]::INTEGER[];
    adresse_id INTEGER;
    nouvel_id INTEGER;
    i INTEGER;
    velo_index INTEGER;
    station_index INTEGER;
    depart DATE;
    noms TEXT[] := ARRAY['Martin', 'Bernard', 'Dubois', 'Thomas', 'Robert',
                         'Richard', 'Petit', 'Durand', 'Leroy', 'Moreau'];
    prenoms TEXT[] := ARRAY['Alice', 'Hugo', 'Emma', 'Louis', 'Chloe',
                            'Gabriel', 'Lea', 'Arthur', 'Manon', 'Jules'];
    lieux TEXT[] := ARRAY['Bastille', 'Republique', 'Place de la Bourse',
                          'Victoire', 'Bellecour', 'Part-Dieu',
                          'Capitole', 'Jean-Jaures', 'Commerce', 'Gare de Nantes'];
    villes TEXT[] := ARRAY['Paris', 'Paris', 'Bordeaux', 'Bordeaux',
                           'Lyon', 'Lyon', 'Toulouse', 'Toulouse',
                           'Nantes', 'Nantes'];
    longitudes DOUBLE PRECISION[] := ARRAY[2.369, 2.364, -0.569, -0.573,
                                            4.833, 4.859, 1.444, 1.449,
                                            -1.558, -1.542];
    latitudes DOUBLE PRECISION[] := ARRAY[48.853, 48.867, 44.841, 44.830,
                                           45.758, 45.760, 43.604, 43.606,
                                           47.214, 47.217];
BEGIN
    -- Stations et leurs adresses dans cinq communes.
    FOR i IN 1..10 LOOP
        INSERT INTO adresses (adresse, commune)
        VALUES (i || ' rue des Velos', villes[i])
        RETURNING id_adresse INTO adresse_id;

        INSERT INTO stations (nom_station, coordones_gps, capacite, id_adresse)
        VALUES (lieux[i],
                ST_SetSRID(ST_MakePoint(longitudes[i], latitudes[i]), 4326)::geography,
                15 + (i % 3) * 5, adresse_id)
        RETURNING id_station INTO nouvel_id;
        stations_ids := array_append(stations_ids, nouvel_id);
    END LOOP;

    -- Adherents et adresses dans les memes communes.
    FOR i IN 1..30 LOOP
        INSERT INTO adresses (adresse, commune)
        VALUES ((i + 10) || ' rue des Lilas', villes[1 + ((i - 1) % 10)])
        RETURNING id_adresse INTO adresse_id;

        INSERT INTO adherents (nom_adherent, prenom, email, numero_tel, dt_adhesion, id_adresse)
        VALUES (noms[1 + ((i - 1) % 10)], prenoms[1 + ((i + 2) % 10)],
                'user' || i || '_' || adresse_id || '@example.org',
                '06' || lpad(i::TEXT, 8, '0'),
                DATE '2026-01-01' + i, adresse_id)
        RETURNING id_adherent INTO nouvel_id;
        adherents_ids := array_append(adherents_ids, nouvel_id);
    END LOOP;

    -- Velos : 40 disponibles, 5 en maintenance, 5 en emprunt.
    FOR i IN 1..50 LOOP
        INSERT INTO velos (marque, modele, dt_mise_en_service, etat,
                           niveau_de_charge_baterie, id_station)
        VALUES (CASE WHEN i % 2 = 0 THEN 'Decathlon' ELSE 'Gitane' END,
                CASE WHEN i % 2 = 0 THEN 'Elops 920 E' ELSE 'e-City' END,
                DATE '2026-03-01' + i,
                CASE WHEN i > 45 THEN 'en emprunt'
                     WHEN i > 40 THEN 'en maintenance' ELSE 'disponible' END,
                30 + ((i * 7) % 71),
                CASE WHEN i > 45 THEN NULL
                     ELSE stations_ids[1 + ((i - 1) % 10)] END)
        RETURNING id_velo INTO nouvel_id;
        velos_ids := array_append(velos_ids, nouvel_id);
    END LOOP;

    -- Trajets termines : depart et arrivee a la station actuelle du velo.
    FOR i IN 1..100 LOOP
        velo_index := 1 + ((i - 1) % 45);
        station_index := 1 + ((velo_index - 1) % 10);
        depart := DATE '2026-09-01' + ((i - 1) / 45) * 7;
        INSERT INTO emprunts (dt_depart, dt_arrive, distance_parcourue,
                              id_velo, id_station_depart, id_station_arrive, id_adherent)
        VALUES (depart, depart, (50 + ((i * 13) % 900)) / 100.0,
                velos_ids[velo_index], stations_ids[station_index],
                stations_ids[station_index], adherents_ids[1 + ((i - 1) % 30)]);
    END LOOP;

    -- Cinq emprunts en cours.
    FOR i IN 46..50 LOOP
        INSERT INTO emprunts (dt_depart, dt_arrive, distance_parcourue,
                              id_velo, id_station_depart, id_station_arrive, id_adherent)
        VALUES (DATE '2026-11-05', NULL, NULL, velos_ids[i],
                stations_ids[1 + ((i - 1) % 10)], NULL, adherents_ids[i - 45]);
    END LOOP;

    -- Duree en minutes ; interventions anterieures aux trajets.
    FOR i IN 1..20 LOOP
        INSERT INTO historique_maintenances
            (dt_intervention, nature_intervention, duree_intervention, id_velo)
        VALUES (DATE '2026-08-01' + i,
                CASE i % 4 WHEN 0 THEN 'Revision generale'
                     WHEN 1 THEN 'Freins' WHEN 2 THEN 'Pneu' ELSE 'Batterie' END,
                20 + (i % 5) * 15, velos_ids[i]);
    END LOOP;
END;
$$;

COMMIT;

SELECT 'adresses' AS table_name, count(*) AS total FROM adresses
UNION ALL SELECT 'stations', count(*) FROM stations
UNION ALL SELECT 'adherents', count(*) FROM adherents
UNION ALL SELECT 'velos', count(*) FROM velos
UNION ALL SELECT 'emprunts', count(*) FROM emprunts
UNION ALL SELECT 'historique_maintenances', count(*) FROM historique_maintenances;
