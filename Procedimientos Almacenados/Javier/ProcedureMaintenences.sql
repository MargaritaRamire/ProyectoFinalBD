--  ------------CREACION DE PROCEDIMIENTOS -FJL  --------------------------

-- 1. Procedimiento para INSERTAR un nuevo mantenimiento

    DELIMITER //
CREATE PROCEDURE sp_maintenances_insert(
    IN p_license_plate VARCHAR(20),
    IN p_type VARCHAR(100),
    IN p_maintenance_date DATE,
    IN p_approved TINYINT(1),
    IN p_status TINYINT(1)
)
BEGIN
    DECLARE vehicle_id INT;

    -- Obtener el ID del vehículo por su placa
    SELECT id_vehicle INTO vehicle_id
    FROM tbl_vehicles
    WHERE license_plate = p_license_plate AND status = 1;

    -- Verificar si el vehículo existe
    IF vehicle_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehículo no encontrado o inactivo';
    END IF;

    -- Insertar el mantenimiento
    INSERT INTO tbl_maintenances (
        id_vehicle,
        type,
        maintenance_date,
        approved,
        status
    ) VALUES (
        vehicle_id,
        p_type,
        p_maintenance_date,
        p_approved,
        p_status
    );

    SELECT 'Mantenimiento insertado correctamente' AS message;
END //
DELIMITER ;

-- 2. Procedimiento para ACTUALIZAR un mantenimiento existente
DELIMITER //
CREATE PROCEDURE sp_maintenances_update(
    IN p_license_plate VARCHAR(20),
    IN p_old_maintenance_date DATE,
    IN p_new_type VARCHAR(100),
    IN p_new_maintenance_date DATE,
    IN p_new_approved TINYINT(1),
    IN p_new_status TINYINT(1)
)
BEGIN
    DECLARE vehicle_id INT;
    DECLARE maintenance_count INT;

    -- Obtener el ID del vehículo por su placa
    SELECT id_vehicle INTO vehicle_id
    FROM tbl_vehicles
    WHERE license_plate = p_license_plate AND status = 1;

    -- Verificar si el vehículo existe
    IF vehicle_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehículo no encontrado o inactivo';
    END IF;

    -- Verificar si existe el mantenimiento a actualizar
    SELECT COUNT(*) INTO maintenance_count
    FROM tbl_maintenances
    WHERE id_vehicle = vehicle_id
    AND maintenance_date = p_old_maintenance_date
    AND status = 1;

    IF maintenance_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mantenimiento no encontrado para la fecha especificada';
    END IF;

    -- Actualizar el mantenimiento
    UPDATE tbl_maintenances
    SET
        type = p_new_type,
        maintenance_date = p_new_maintenance_date,
        approved = p_new_approved,
        status = p_new_status,
        updated_at = CURRENT_TIMESTAMP
    WHERE id_vehicle = vehicle_id
    AND maintenance_date = p_old_maintenance_date
    AND status = 1;

    SELECT 'Mantenimiento actualizado correctamente' AS message;
END //
DELIMITER ;

-- 3. Procedimiento para OBTENER TODOS los mantenimientos

    DELIMITER //
CREATE PROCEDURE sp_maintenances_get_all()
BEGIN
    SELECT
        m.id_maintenance,
        v.license_plate AS placa_vehiculo,
        v.plates AS numero_placa,
        m.type AS tipo_mantenimiento,
        m.maintenance_date AS fecha_mantenimiento,
        CASE
            WHEN m.approved = 1 THEN 'Aprobado'
            ELSE 'Pendiente'
        END AS estado_aprobacion,
        CASE
            WHEN m.status = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS estado_mantenimiento,
        m.created_at AS fecha_creacion,
        m.updated_at AS fecha_actualizacion
    FROM tbl_maintenances m
    INNER JOIN tbl_vehicles v ON m.id_vehicle = v.id_vehicle
    WHERE m.status = 1
    ORDER BY v.license_plate, m.maintenance_date DESC;
END //
DELIMITER ;

-- 4. Procedimiento para OBTENER un mantenimiento por placa
DELIMITER //
CREATE PROCEDURE sp_maintenances_get_by_plate(
    IN p_license_plate VARCHAR(20)
)
BEGIN
    DECLARE vehicle_id INT;

    -- Obtener el ID del vehículo por su placa
    SELECT id_vehicle INTO vehicle_id
    FROM tbl_vehicles
    WHERE license_plate = p_license_plate AND status = 1;

    -- Verificar si el vehículo existe
    IF vehicle_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehículo no encontrado o inactivo';
    END IF;

    -- Obtener todos los mantenimientos del vehículo
    SELECT
        m.id_maintenance,
        v.license_plate,
        m.type,
        m.maintenance_date,
        m.approved,
        m.status,
        m.created_at,
        m.updated_at
    FROM tbl_maintenances m
    INNER JOIN tbl_vehicles v ON m.id_vehicle = v.id_vehicle
    WHERE m.id_vehicle = vehicle_id
    AND m.status = 1
    ORDER BY m.maintenance_date DESC;
END //
DELIMITER ;

-- 5. Procedimiento para ELIMINAR (desactivar) un mantenimiento / por placa y fecha

DELIMITER //
CREATE PROCEDURE sp_maintenances_delete(
    IN p_license_plate VARCHAR(20),
    IN p_maintenance_date DATE
)
BEGIN
    DECLARE vehicle_id INT;
    DECLARE maintenance_count INT;

    -- Obtener el ID del vehículo por su placa
    SELECT id_vehicle INTO vehicle_id
    FROM tbl_vehicles
    WHERE license_plate = p_license_plate AND status = 1;

    -- Verificar si el vehículo existe
    IF vehicle_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehículo no encontrado o inactivo';
    END IF;

    -- Verificar si existe el mantenimiento a eliminar
    SELECT COUNT(*) INTO maintenance_count
    FROM tbl_maintenances
    WHERE id_vehicle = vehicle_id
    AND maintenance_date = p_maintenance_date
    AND status = 1;

    IF maintenance_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mantenimiento no encontrado para la fecha especificada';
    END IF;

    -- Eliminar (desactivar) el mantenimiento
    UPDATE tbl_maintenances
    SET
        status = 0,
        updated_at = CURRENT_TIMESTAMP
    WHERE id_vehicle = vehicle_id
    AND maintenance_date = p_maintenance_date
    AND status = 1;

    SELECT 'Mantenimiento eliminado correctamente' AS message;
END //
DELIMITER ;

-- ---------------- LAMADO PARA PROCESOS ALMACENADOS / CALL LIST PROCEDURES  -------------------

-- call procedure insert
-- Insertar un nuevo mantenimiento
CALL sp_maintenances_insert(
    'ABC1234',                   -- p_license_plate (placa del vehículo)
    'Cambio de aceite',         -- p_type (tipo de mantenimiento)
    '2025-08-25',               -- p_maintenance_date (fecha del mantenimiento)
    1,                          -- p_approved (1 = aprobado, 0 = pendiente)
    1                           -- p_status (1 = activo, 0 = inactivo)
);

-- call update procedure
-- Actualizar un mantenimiento existente
CALL sp_maintenances_update(
    'ABC123',                   -- p_license_plate (placa del vehículo)
    '2025-08-25',               -- p_old_maintenance_date (fecha original del mantenimiento)
    'Mantenimiento completo',   -- p_new_type (nuevo tipo)
    '2025-08-30',               -- p_new_maintenance_date (nueva fecha)
    1,                          -- p_new_approved (1 = aprobado, 0 = pendiente)
    1                           -- p_new_status (1 = activo, 0 = inactivo)
);

-- call procedure get all
-- Obtener todos los mantenimientos activos
CALL sp_maintenances_get_all();

-- call procedure find ID
-- Obtener un mantenimiento específico por su placa
CALL sp_maintenances_get_by_plate('ABC123');  -- p_license_plate

-- call procedure delete
-- Eliminar (desactivar) un mantenimiento por placa y fecha
CALL sp_maintenances_delete(
    'ABC123',                   -- p_license_plate (placa del vehículo)
    '2025-08-25'                -- p_maintenance_date (fecha del mantenimiento a eliminar)
);



-- -------------------------PRUEBA DE INSERCION DE DATOS --------------------------------------

-- Insertar vehículo de prueba si no tienes
INSERT INTO tbl_vehicles (license_plate, capacity, plates, available, status)
VALUES ('ABC1234', 1500, '033HZX', 1, 1);

-- Verificar que se insertó
SELECT * FROM tbl_vehicles WHERE license_plate = 'ABC123';


-- ---------------------PRUEBAS -----------------------------------

-- 1. PRIMERO verifica las placas disponibles
SELECT license_plate FROM tbl_vehicles WHERE status = 1;

-- 2. INSERTAR un nuevo mantenimiento
CALL sp_maintenances_insert('ABC123', 'Revisión general', '2025-08-25', 0, 1);

-- 3. VER todos los mantenimientos (para confirmar)
CALL sp_maintenances_get_all();

-- 4. VER solo los del vehículo ABC123
CALL sp_maintenances_get_by_plate('ABC123');

-- 5. ACTUALIZAR el mantenimiento (aprobar y cambiar fecha)
CALL sp_maintenances_update('ABC123', '2025-08-25', 'Revisión completa', '2025-08-26', 1, 1);

-- 6. ELIMINAR el mantenimiento
CALL sp_maintenances_delete('ABC123', '2025-08-26');

-- 7. VERIFICAR que ya no aparece
CALL sp_maintenances_get_all();