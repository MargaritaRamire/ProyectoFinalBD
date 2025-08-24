
-- =========================================================
-- ===============  STORED PROCEDURES  =====================
-- =========================================================
USE logistics;
DROP PROCEDURE IF EXISTS sp_tbl_alert_statuses_insert;
DROP PROCEDURE IF EXISTS sp_tbl_alert_statuses_update;
DROP PROCEDURE IF EXISTS sp_tbl_alert_statuses_delete;
DROP PROCEDURE IF EXISTS sp_tbl_alert_statuses_getAll;
DROP PROCEDURE IF EXISTS sp_tbl_alert_statuses_getById;
--------------------------------------------------
--------------tbl_alert_statuses_insert-----------
--------------------------------------------------
DELIMITER $$

-- 1) INSERT
CREATE PROCEDURE sp_tbl_alert_statuses_insert (
    IN p_name_alert   VARCHAR(50),
    IN p_description  TEXT,
    IN p_threshold_km DECIMAL(10,2)
)
BEGIN
    INSERT INTO tbl_alert_statuses (name_alert, description, threshold_km)
    VALUES (p_name_alert, p_description, p_threshold_km);
END$$

-- 2) UPDATE
CREATE PROCEDURE sp_tbl_alert_statuses_update (
    IN p_id_alert     INT,
    IN p_name_alert   VARCHAR(50),
    IN p_description  TEXT,
    IN p_threshold_km DECIMAL(10,2)
)
BEGIN
    UPDATE tbl_alert_statuses
    SET name_alert   = p_name_alert,
        description  = p_description,
        threshold_km = p_threshold_km,
        updated_at   = NOW()
    WHERE id_alert = p_id_alert;
END$$

-- 3) DELETE
CREATE PROCEDURE sp_tbl_alert_statuses_delete (
    IN p_id_alert INT
)
BEGIN
    DELETE FROM tbl_alert_statuses
    WHERE id_alert = p_id_alert;
END$$

-- 4) GET ALL
CREATE PROCEDURE sp_tbl_alert_statuses_getAll ()
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses
    ORDER BY id_alert DESC;
END$$

-- 5) GET BY ID
CREATE PROCEDURE sp_tbl_alert_statuses_getById (
    IN p_id_alert INT
)
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses
    WHERE id_alert = p_id_alert;
END$$

DELIMITER ;
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

CALL sp_tbl_alert_statuses_insert('Exceso KM', 'Se excedió el umbral', 12.50);
CALL sp_tbl_alert_statuses_getAll();
CALL sp_tbl_alert_statuses_getById(1);
CALL sp_tbl_alert_statuses_update(1, 'Ajuste Umbral', 'Descripción actualizada', 15.00);
CALL sp_tbl_alert_statuses_delete(1);
----------------------------------------------------------------------------------------
------------------------tbl_vehicle_types_insert----------------------------------------
----------------------------------------------------------------------------------------
-- 1. Insertar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicle_types_insert (
    IN p_name_type VARCHAR(100),
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO tbl_vehicle_types (name_type, description, created_at, updated_at)
    VALUES (p_name_type, p_description, NOW(), NOW());
END //
DELIMITER ;


-- 2. Actualizar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicle_types_update (
    IN p_id_vehicle_type INT,
    IN p_name_type VARCHAR(100),
    IN p_description VARCHAR(255)
)
BEGIN
    UPDATE tbl_vehicle_types
    SET name_type  = p_name_type,
        description = p_description,
        updated_at = NOW()
    WHERE id_vehicle_type = p_id_vehicle_type;
END //
DELIMITER ;


-- 3. Eliminar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicle_types_delete (
    IN p_id_vehicle_type INT
)
BEGIN
    DELETE FROM tbl_vehicle_types
    WHERE id_vehicle_type = p_id_vehicle_type;
END //
DELIMITER ;


-- 4. Obtener por ID
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicle_types_getById (
    IN p_id_vehicle_type INT
)
BEGIN
    SELECT *
    FROM tbl_vehicle_types
    WHERE id_vehicle_type = p_id_vehicle_type;
END //
DELIMITER ;


-- 5. Obtener todos
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicle_types_getAll ()
BEGIN
    SELECT *
    FROM tbl_vehicle_types;
END //
DELIMITER ;

----------------------------------------------------------------
----------------tbl_vehicles_insert-----------------------------
    ------------------------------------------------------------

-- 1. Insertar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicles_insert (
    IN p_plate VARCHAR(20),
    IN p_model VARCHAR(100),
    IN p_capacity DECIMAL(10,2),
    IN p_id_vehicle_type INT
)
BEGIN
    INSERT INTO tbl_vehicles (plate, model, capacity, id_vehicle_type, created_at, updated_at)
    VALUES (p_plate, p_model, p_capacity, p_id_vehicle_type, NOW(), NOW());
END //
DELIMITER ;


-- 2. Actualizar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicles_update (
    IN p_id_vehicle INT,
    IN p_plate VARCHAR(20),
    IN p_model VARCHAR(100),
    IN p_capacity DECIMAL(10,2),
    IN p_id_vehicle_type INT
)
BEGIN
    UPDATE tbl_vehicles
    SET plate = p_plate,
        model = p_model,
        capacity = p_capacity,
        id_vehicle_type = p_id_vehicle_type,
        updated_at = NOW()
    WHERE id_vehicle = p_id_vehicle;
END //
DELIMITER ;


-- 3. Eliminar
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicles_delete (
    IN p_id_vehicle INT
)
BEGIN
    DELETE FROM tbl_vehicles
    WHERE id_vehicle = p_id_vehicle;
END //
DELIMITER ;


-- 4. Obtener por ID
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicles_getById (
    IN p_id_vehicle INT
)
BEGIN
    SELECT *
    FROM tbl_vehicles
    WHERE id_vehicle = p_id_vehicle;
END //
DELIMITER ;


-- 5. Obtener todos
DELIMITER //
CREATE PROCEDURE sp_tbl_vehicles_getAll ()
BEGIN
    SELECT *
    FROM tbl_vehicles;
END //
DELIMITER ;
------------------------------------------------------------------------------------
    --------------------------tbl_departments_insert--------------------------------
    --------------------------------------------------------------------------------

DELIMITER $$

-- 1) INSERT
CREATE PROCEDURE sp_tbl_departments_insert (
    IN p_name_department VARCHAR(50),
    IN p_description     TEXT
)
BEGIN
    INSERT INTO tbl_departments (name_department, description)
    VALUES (p_name_department, p_description);
END$$

-- 2) UPDATE
CREATE PROCEDURE sp_tbl_departments_update (
    IN p_id_department   INT,
    IN p_name_department VARCHAR(50),
    IN p_description     TEXT
)
BEGIN
    UPDATE tbl_departments
    SET name_department = p_name_department,
        description     = p_description,
        updated_at      = NOW()
    WHERE id_department = p_id_department;
END$$

-- 3) DELETE
CREATE PROCEDURE sp_tbl_departments_delete (
    IN p_id_department INT
)
BEGIN
    DELETE FROM tbl_departments
    WHERE id_department = p_id_department;
END$$

-- 4) GET ALL
CREATE PROCEDURE sp_tbl_departments_getAll ()
BEGIN
    SELECT id_department, name_department, description, created_at, updated_at
    FROM tbl_departments
    ORDER BY id_department DESC;
END$$

-- 5) GET BY ID
CREATE PROCEDURE sp_tbl_departments_getById (
    IN p_id_department INT
)
BEGIN
    SELECT id_department, name_department, description, created_at, updated_at
    FROM tbl_departments
    WHERE id_department = p_id_department;
END$$

DELIMITER ;
--------------------------------------------------------
--------------------tbl_municipalities_insert-----------
--------------------------------------------------------

DELIMITER $$

-- 1) INSERT
CREATE PROCEDURE sp_tbl_municipalities_insert (
    IN p_name_municipality VARCHAR(50),
    IN p_id_department      INT,
    IN p_description        TEXT
)
BEGIN
    INSERT INTO tbl_municipalities (name_municipality, id_department, description)
    VALUES (p_name_municipality, p_id_department, p_description);
END$$

-- 2) UPDATE
CREATE PROCEDURE sp_tbl_municipalities_update (
    IN p_id_municipality   INT,
    IN p_name_municipality  VARCHAR(50),
    IN p_id_department      INT,
    IN p_description        TEXT
)
BEGIN
    UPDATE tbl_municipalities
    SET name_municipality = p_name_municipality,
        id_department     = p_id_department,
        description       = p_description,
        updated_at        = NOW()
    WHERE id_municipality = p_id_municipality;
END$$

-- 3) DELETE
CREATE PROCEDURE sp_tbl_municipalities_delete (
    IN p_id_municipality INT
)
BEGIN
    DELETE FROM tbl_municipalities
    WHERE id_municipality = p_id_municipality;
END$$

-- 4) GET ALL
CREATE PROCEDURE sp_tbl_municipalities_getAll ()
BEGIN
    SELECT id_municipality, name_municipality, id_department, description, created_at, updated_at
    FROM tbl_municipalities
    ORDER BY id_municipality DESC;
END$$

-- 5) GET BY ID
CREATE PROCEDURE sp_tbl_municipalities_getById (
    IN p_id_municipality INT
)
BEGIN
    SELECT id_municipality, name_municipality, id_department, description, created_at, updated_at
    FROM tbl_municipalities
    WHERE id_municipality = p_id_municipality;
END$$

DELIMITER ;

-----------------------------------------------
---------tbl_distances_insert------------------
-----------------------------------------------
DELIMITER $$

-- 1) INSERT
CREATE PROCEDURE sp_tbl_distances_insert (
    IN p_id_municipality_from INT,
    IN p_id_municipality_to   INT,
    IN p_distance_km          DECIMAL(10,2)
)
BEGIN
    INSERT INTO tbl_distances (id_municipality_from, id_municipality_to, distance_km)
    VALUES (p_id_municipality_from, p_id_municipality_to, p_distance_km);
END$$

-- 2) UPDATE
CREATE PROCEDURE sp_tbl_distances_update (
    IN p_id_distance         INT,
    IN p_id_municipality_from INT,
    IN p_id_municipality_to   INT,
    IN p_distance_km          DECIMAL(10,2)
)
BEGIN
    UPDATE tbl_distances
    SET id_municipality_from = p_id_municipality_from,
        id_municipality_to   = p_id_municipality_to,
        distance_km          = p_distance_km,
        updated_at           = NOW()
    WHERE id_distance = p_id_distance;
END$$

-- 3) DELETE
CREATE PROCEDURE sp_tbl_distances_delete (
    IN p_id_distance INT
)
BEGIN
    DELETE FROM tbl_distances
    WHERE id_distance = p_id_distance;
END$$

-- 4) GET ALL
CREATE PROCEDURE sp_tbl_distances_getAll ()
BEGIN
    SELECT id_distance, id_municipality_from, id_municipality_to, distance_km, created_at, updated_at
    FROM tbl_distances
    ORDER BY id_distance DESC;
END$$

-- 5) GET BY ID
CREATE PROCEDURE sp_tbl_distances_getById (
    IN p_id_distance INT
)
BEGIN
    SELECT id_distance, id_municipality_from, id_municipality_to, distance_km, created_at, updated_at
    FROM tbl_distances
    WHERE id_distance = p_id_distance;
END$$

DELIMITER ;