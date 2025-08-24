

-- ============================================
-- INSERT
-- ============================================
DELIMITER $$
CREATE PROCEDURE sp_vehicles_insert (
    IN p_license_plate VARCHAR(20),
    IN p_capacity INT,
    IN p_plates VARCHAR(20),
    IN p_available TINYINT(1),
    IN p_status TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_vehicles (license_plate, capacity, plates, available, status, created_at, updated_at)
    VALUES (p_license_plate, p_capacity, p_plates, p_available, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_vehicles_update (
    IN p_id_vehicle INT,
    IN p_license_plate VARCHAR(20),
    IN p_capacity INT,
    IN p_plates VARCHAR(20),
    IN p_available TINYINT(1),
    IN p_status TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_vehicles
    SET license_plate = p_license_plate,
        capacity      = p_capacity,
        plates        = p_plates,
        available     = p_available,
        status        = p_status,
        updated_at    = NOW()
    WHERE id_vehicle = p_id_vehicle;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_vehicles_get_all ()
BEGIN
    SELECT id_vehicle, license_plate, capacity, plates, available, status, created_at, updated_at
    FROM tbl_vehicles
    WHERE status = 1; -- Solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_vehicles_get_by_id (
    IN p_id_vehicle INT
)
BEGIN
    SELECT id_vehicle, license_plate, capacity, plates, available, status, created_at, updated_at
    FROM tbl_vehicles
    WHERE id_vehicle = p_id_vehicle;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_vehicles_delete (
    IN p_id_vehicle INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_vehicles
    SET status = 0,
        updated_at = NOW()
    WHERE id_vehicle = p_id_vehicle;

    COMMIT;
END$$

DELIMITER ;
INSERT INTO tbl_vehicles (license_plate, capacity, plates, available, status, created_at, updated_at)
VALUES
('P123ABC', 5000, 'ABC123', 1, 1, NOW(), NOW()),
('P456DEF', 3500, 'DEF456', 1, 1, NOW(), NOW()),
('C789GHI', 8000, 'GHI789', 0, 1, NOW(), NOW());

-- Insertar nuevo vehículo
CALL sp_vehicles_insert('P111JKL', 4000, 'JKL111', 1, 1);

-- Ver todos los vehículos activos
CALL sp_vehicles_get_all();

-- Obtener un vehículo específico
CALL sp_vehicles_get_by_id(1);

-- Actualizar vehículo
CALL sp_vehicles_update(2, 'P222MNO', 4500, 'MNO222', 1, 1);

-- Eliminar lógicamente (status = 0)
CALL sp_vehicles_delete(3);

