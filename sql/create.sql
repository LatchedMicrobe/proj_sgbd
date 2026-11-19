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
    id_velo                         SERIAL                  NOT NULL,
    marque                          VARCHAR(20)                     ,
    modele                          VARCHAR(20)                     ,
    dt_mise_en_service              DATE                            ,
    etat                            VARCHAR(20)                     ,
    niveau_de_charge_baterie        INTEGER                         ,
    id_station                      INTEGER                         , 
    CONSTRAINT pk_velo PRIMARY KEY (id_velo)                       
);

-- ============================================================
--   Table : Historique Maintenance                                            
-- ============================================================
CREATE TABLE historique_maintenances
(
    id_maintenance                  SERIAL                  NOT NULL,
    dt_intervention                 DATE                            ,
    nature_intervention             VARCHAR(20)                     ,
    duree_intervention              INTEGER                         ,
    id_velo                         INTEGER                 NOT NULL, 
    CONSTRAINT pk_maintenance PRIMARY KEY (id_maintenance)         
);

-- ============================================================
--   Table : Stations                                            
-- ============================================================
CREATE TABLE stations
(
    id_station                      SERIAL                 NOT NULL,
    nom_station                     VARCHAR(20)                    ,
    coordones_gps                   GEOGRAPHY(POINT, 4326)         ,
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
    nom_adherent                    VARCHAR(20)                    ,
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
    id_emprunt                      SERIAL                  NOT NULL,
    dt_depart                       DATE                    NOT NULL,
    dt_arrive                       DATE                            ,
    temps_depart                    TIME                            ,
    temps_arrive                    TIME                            ,
    distance_parcourue              NUMERIC(3,2)                    ,
    id_velo                         INTEGER                 NOT NULL,
    id_station_depart               INTEGER                 NOT NULL,
    id_station_arrive               INTEGER                         ,
    id_adherent                     INTEGER                 NOT NULL,
    CONSTRAINT pk_emprunt PRIMARY KEY (id_emprunt)                 
);

-- ============================================================
--   Table : Adresses                                            
-- ============================================================
CREATE TABLE adresses
(
    id_adresse                      SERIAL                  NOT NULL,
    adresse                         VARCHAR(20)                     ,
    commune                         VARCHAR(20)                     ,
    CONSTRAINT pk_adresse PRIMARY KEY (id_adresse)                 
);

-- ============================================================
--   Constraints FK tables                                           
-- ============================================================

ALTER TABLE velos
    ADD CONSTRAINT fk_velo FOREIGN KEY (id_station)
       REFERENCES stations (id_station);

ALTER TABLE historique_maintenances
    ADD CONSTRAINT fk_maintenance FOREIGN KEY (id_velo)
       REFERENCES velos (id_velo);

ALTER TABLE stations
    ADD CONSTRAINT fk_station FOREIGN KEY (id_adresse)
       REFERENCES adresses (id_adresse);

ALTER TABLE adherents
    ADD CONSTRAINT fk_adherent FOREIGN KEY (id_adresse)
       REFERENCES adresses (id_adresse);

ALTER TABLE emprunts
    ADD CONSTRAINT fk1_emprunt FOREIGN KEY (id_velo)
       REFERENCES velos (id_velo),
    ADD CONSTRAINT fk2_emprunt FOREIGN KEY (id_station_depart)
       REFERENCES stations (id_station),
    ADD CONSTRAINT fk3_emprunt FOREIGN KEY (id_station_arrive)
       REFERENCES stations (id_station),
    ADD CONSTRAINT fk4_emprunt FOREIGN KEY (id_adherent)
       REFERENCES adherents (id_adherent);

-- ============================================================
--   Constraints check tables                                          
-- ============================================================

ALTER TABLE velos
    ADD CONSTRAINT chk_velo CHECK (velos.etat IN ('disponible','en enprunt','en maintenance','en panne'));
    --TODO: A station can only have a number of relationships with velos at most equal to its max capacity (use functions)

-- ============================================================
--   Triggers tables                                          
-- ============================================================
    --TODO: A adhrent can only have a single emprunt "en cours" (discuss if emprunt should have attribut etat), for now implement using dt arrive IS NULL
    --TODO (probably with multiple triggers): Update etat of velo according to the relationship it gets (if it has a relationship stocke, is disponible, if we insert the velo in a relationship with emprunt, it should change to en emprunt, the same with maintenance)
        --Restriction: A velo can only be in emprunt if its state is disponible and if its battery is suficient
        --Restriction: Check the etat variable to decided if it even can enter that relationship
        --Restriction: Every time a velo currently en emprunt is stocked in a station, put the the arrived station in emprunt and change status of velo
    --TODO: Distance parcorue must be, at least, the distance between the two stations
   
