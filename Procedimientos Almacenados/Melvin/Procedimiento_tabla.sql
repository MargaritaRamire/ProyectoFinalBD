DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_kilometers_insert (
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_kilometers_traveled DECIMAL(10,2),
    IN p_id_alert INT,
    IN p_record_date DATE,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_kilometers (id_delivery, id_vehicle, kilometers_traveled, id_alert, record_date, status, created_at, updated_at)
    VALUES (p_id_delivery, p_id_vehicle, p_kilometers_traveled, p_id_alert, p_record_date, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_kilometers_update (
    IN p_id_kilometer INT,
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_kilometers_traveled DECIMAL(10,2),
    IN p_id_alert INT,
    IN p_record_date DATE,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_kilometers
    SET id_delivery = p_id_delivery,
        id_vehicle = p_id_vehicle,
        kilometers_traveled = p_kilometers_traveled,
        id_alert = p_id_alert,
        record_date = p_record_date,
        status = p_status,
        updated_at = NOW()
    WHERE id_kilometer = p_id_kilometer;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_kilometers_get_all ()
BEGIN
    SELECT id_kilometer, id_delivery, id_vehicle, kilometers_traveled, id_alert, record_date, status, created_at, updated_at
    FROM tbl_kilometers
    WHERE status = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_kilometers_get_by_id (
    IN p_id_kilometer INT
)
BEGIN
    SELECT id_kilometer, id_delivery, id_vehicle, kilometers_traveled, id_alert, record_date, status, created_at, updated_at
    FROM tbl_kilometers
    WHERE id_kilometer = p_id_kilometer;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_kilometers_delete (
    IN p_id_kilometer INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_kilometers
    SET status = 0,
        updated_at = NOW()
    WHERE id_kilometer = p_id_kilometer;

    COMMIT;
END$$

DELIMITER ;

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

-- Alertas
INSERT INTO tbl_alert_statuses (name_alert, description, threshold_km)
VALUES ('Mantenimiento preventivo', 'Revisión general después de 5000 km', 5000.00);

-- Vehículo
INSERT INTO tbl_vehicles (license_plate, capacity, plates)
VALUES ('P123ABC', 5000, '123ABC');

-- Departamento y municipio (para poder crear rutas y deliveries)
INSERT INTO tbl_departments (name_department) VALUES ('Guatemala');
INSERT INTO tbl_municipalities (name_municipality, id_department) VALUES ('Zona 1', 1);
INSERT INTO tbl_municipalities (name_municipality, id_department) VALUES ('Zona 2', 1);

-- Ruta
INSERT INTO tbl_routes (id_origin, id_destination, distance_km)
VALUES (1, 2, 15.00);

-- Estado de delivery
INSERT INTO tbl_delivery_statuses (name_status)
VALUES ('En tránsito');

-- Delivery
INSERT INTO tbl_deliveries (delivery_date, delivery_status, id_route, id_status)
VALUES (CURDATE(), 'En tránsito', 1, 1);

-- ============================================
-- PRUEBAS DE LOS PROCEDIMIENTOS
-- ============================================

-- Insertar registros en tbl_kilometers
CALL sp_kilometers_insert(1, 1, 150.75, 1, CURDATE(), 1);
CALL sp_kilometers_insert(1, 1, 325.40, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 1);

-- Consultar todos
CALL sp_kilometers_get_all();

-- Consultar uno por ID
CALL sp_kilometers_get_by_id(1);

-- Actualizar registro (ejemplo: ID=1)
CALL sp_kilometers_update(1, 1, 1, 200.50, 1, CURDATE(), 1);

-- Eliminar lógico (ejemplo: ID=2)
CALL sp_kilometers_delete(2);

-- Consultar todos de nuevo
CALL sp_kilometers_get_all();