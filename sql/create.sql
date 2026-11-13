-- ============================================================
--   Nom de la base   :  Flotte de Vélos                                
--   Nom de SGBD      :  PostgreSQL                   
--   Date de creation :  05/11/2026                       
-- ============================================================

-- ============================================================
--   Table : Vélos                                            
-- ============================================================

CREATE TABLE velos
(
    id_velo                         SERIAL                 NOT NULL,
    marque                          VARCHAR(20)                    ,
    modele                          VARCHAR(20)                    ,
    dt_mise_en_service              DATE                           ,
    etat                            VARCHAR(20)                    ,
    niveau_de_charge_baterie        INTEGER                        ,
    id_station                      INTEGER                        , 
    CONSTRAINT pk_velo PRIMARY KEY (id_velo)                       
);

-- ============================================================
--   Table : Historique Maintenance                                            
-- ============================================================
CREATE TABLE historique_maintenances
(
    id_maintenance                  SERIAL                 NOT NULL,
    dt_interventions                DATE                           ,
    nature_interventions            VARCHAR(20)                    ,
    duree_interventions             INTEGER                        ,
    id_velo                         INTEGER                NOT NULL, 
    CONSTRAINT pk_maintenance PRIMARY KEY (id_maintenance)         
);

-- ============================================================
--   Table : Stations                                            
-- ============================================================
CREATE TABLE stations
(
    id_station                      SERIAL                 NOT NULL,
    nom_station                             VARCHAR(20)                    ,
    coordones_gps                   GEOGRAPHY(POINT, 4326)                ,
    capacite                        INTEGER                        ,
    id_adresse                      INTEGER    UNIQUE      NOT NULL, 
    CONSTRAINT pk_station PRIMARY KEY (id_station)                 
);

-- ============================================================
--   Table : Adhérents                                            
-- ============================================================
CREATE TABLE adherents
(
    id_adherent                     SERIAL                 NOT NULL,
    nom                             VARCHAR(20)                    ,
    prenom                          VARCHAR(20)                    ,
    email                           VARCHAR(20)                    ,
    numero_tel                      VARCHAR(20)                    ,
    dt_adhesion                     DATE                           ,
    id_adresse                      INTEGER                NOT NULL,     
    CONSTRAINT pk_adherent PRIMARY KEY (id_adherent)               
);

-- ============================================================
--   Table : Emprunts                                            
-- ============================================================
CREATE TABLE emprunts
(
    id_emprunt                      SERIAL                 NOT NULL,
    dt_departure                    DATE                           ,
    dt_arrive                       DATE                           ,
    distance_parcourue              NUMERIC(3,2)                   ,
    id_velo                         INTEGER                NOT NULL,
    id_station_depart               INTEGER                NOT NULL,
    id_station_arrive               INTEGER                        ,
    id_adherent                     INTEGER                NOT NULL,
    CONSTRAINT pk_emprunt PRIMARY KEY (id_emprunt)                 
);

-- ============================================================
--   Table : Adresses                                            
-- ============================================================
CREATE TABLE adresses
(
    id_adresse                      SERIAL                 NOT NULL,
    adresse                         VARCHAR(20)                    ,
    commune                         VARCHAR(20)                    ,
    CONSTRAINT pk_adresse PRIMARY KEY (id_adresse)                 
);

ALTER TABLE velos
    ADD CONSTRAINT fk_velo FOREIGN KEY (id_station)
       REFERENCES             stations (id_station);

ALTER TABLE historique_maintenances
    ADD CONSTRAINT fk_maintenance FOREIGN KEY (id_velo)
       REFERENCES                       velos (id_velo);

ALTER TABLE stations
    ADD CONSTRAINT fk_station FOREIGN KEY (id_adresse)
       REFERENCES                adresses (id_adresse);

ALTER TABLE adherents
    ADD CONSTRAINT fk_adherent FOREIGN KEY (id_adresse)
       REFERENCES              adresses (id_adresse);

ALTER TABLE emprunts
    ADD CONSTRAINT fk1_emprunt FOREIGN KEY (id_velo)
       REFERENCES                    velos (id_velo),
    ADD CONSTRAINT fk2_emprunt FOREIGN KEY (id_station_depart)
       REFERENCES                        stations (id_station),
    ADD CONSTRAINT fk3_emprunt FOREIGN KEY (id_station_arrive)
       REFERENCES                        stations (id_station),
    ADD CONSTRAINT fk4_emprunt FOREIGN KEY (id_adherent)
       REFERENCES                adherents (id_adherent);