DELIMITER $$

-- =========================
-- INSERT
-- =========================
CREATE PROCEDURE sp_maintenance_requests_insert (
    IN p_id_vehicle INT,
    IN p_request_date DATE,
    IN p_reason TEXT,
    IN p_approved_by INT,      -- puede ser NULL
    IN p_status TINYINT        -- 1 activo, 0 inactivo
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_maintenance_requests
        (id_vehicle, request_date, reason, approved_by, status, created_at, updated_at)
    VALUES
        (p_id_vehicle, p_request_date, p_reason, p_approved_by, p_status, NOW(), NOW());

    COMMIT;
END$$

-- =========================
-- UPDATE
-- =========================
CREATE PROCEDURE sp_maintenance_requests_update (
    IN p_id_request INT,
    IN p_id_vehicle INT,
    IN p_request_date DATE,
    IN p_reason TEXT,
    IN p_approved_by INT,      -- puede ser NULL
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_maintenance_requests
    SET id_vehicle   = p_id_vehicle,
        request_date = p_request_date,
        reason       = p_reason,
        approved_by  = p_approved_by,
        status       = p_status,
        updated_at   = NOW()
    WHERE id_request = p_id_request;

    COMMIT;
END$$

-- =========================
-- GET ALL (solo activos)
-- =========================
CREATE PROCEDURE sp_maintenance_requests_get_all ()
BEGIN
    SELECT id_request, id_vehicle, request_date, reason, approved_by,
           status, created_at, updated_at
    FROM tbl_maintenance_requests
    WHERE status = 1
    ORDER BY request_date DESC, id_request DESC;
END$$

-- =========================
-- GET BY ID
-- =========================
CREATE PROCEDURE sp_maintenance_requests_get_by_id (
    IN p_id_request INT
)
BEGIN
    SELECT id_request, id_vehicle, request_date, reason, approved_by,
           status, created_at, updated_at
    FROM tbl_maintenance_requests
    WHERE id_request = p_id_request;
END$$

-- =========================
-- DELETE (lógico)
-- =========================
CREATE PROCEDURE sp_maintenance_requests_delete (
    IN p_id_request INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_maintenance_requests
    SET status = 0,
        updated_at = NOW()
    WHERE id_request = p_id_request;

    COMMIT;
END$$

DELIMITER ;

-- ///////////////////////////////////////////////
-- ============================================
-- Datos iniciales de prueba para tbl_maintenance_requests
-- ============================================

INSERT INTO tbl_maintenance_requests (id_vehicle, request_date, reason, approved_by, status, created_at, updated_at)
VALUES
(1, '2025-08-20', 'Cambio de aceite y filtros', NULL, 1, NOW(), NOW()),
(2, '2025-08-21', 'Revisión de frenos delanteros', NULL, 1, NOW(), NOW()),
(3, '2025-08-22', 'Falla en el sistema eléctrico', 2, 1, NOW(), NOW()),
(1, '2025-08-23', 'Inspección preventiva de neumáticos', NULL, 1, NOW(), NOW()),
(4, '2025-08-24', 'Solicitud por ruido en motor', 3, 1, NOW(), NOW());

-- ///////////////////////////////////////////////

-- ============================================
-- Probar los procedimientos
-- ============================================

-- Insertar una nueva solicitud
CALL sp_maintenance_requests_insert(
    2, '2025-08-25', 'Cambio de batería', NULL, 1
);

-- Obtener todas las solicitudes activas
CALL sp_maintenance_requests_get_all();

-- Obtener una solicitud específica (ejemplo: id 1)
CALL sp_maintenance_requests_get_by_id(1);

-- Actualizar una solicitud existente (ejemplo id = 2)
CALL sp_maintenance_requests_update(
    2, 2, '2025-08-26', 'Revisión de suspensión trasera', 4, 1
);

-- Eliminar lógicamente una solicitud (ejemplo id = 3)
CALL sp_maintenance_requests_delete(3);

-- Volver a consultar todas las solicitudes activas
CALL sp_maintenance_requests_get_all();
