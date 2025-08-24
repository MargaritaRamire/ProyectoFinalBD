
-- ============================================
-- INSERT
-- ============================================
DELIMITER $$
CREATE PROCEDURE sp_departments_insert (
    IN p_name_department VARCHAR(100),
    IN p_status_department TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_departments (name_department, status_department, created_at, updated_at)
    VALUES (p_name_department, p_status_department, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_departments_update (
    IN p_id_department INT,
    IN p_name_department VARCHAR(100),
    IN p_status_department TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_departments
    SET name_department = p_name_department,
        status_department = p_status_department,
        updated_at = NOW()
    WHERE id_department = p_id_department;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_departments_get_all ()
BEGIN
    SELECT id_department, name_department, status_department, created_at, updated_at
    FROM tbl_departments
    WHERE status_department = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_departments_get_by_id (
    IN p_id_department INT
)
BEGIN
    SELECT id_department, name_department, status_department, created_at, updated_at
    FROM tbl_departments
    WHERE id_department = p_id_department;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_departments_delete (
    IN p_id_department INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_departments
    SET status_department = 0,
        updated_at = NOW()
    WHERE id_department = p_id_department;

    COMMIT;
END$$

DELIMITER ;

-- FUNCIONES PARA LLAMAR PROCEDIMIENTOS --
INSERT INTO tbl_departments (name_department, status_department, created_at, updated_at)
VALUES
('Guatemala', 1, NOW(), NOW()),
('Sacatepéquez', 1, NOW(), NOW()),
('Quetzaltenango', 1, NOW(), NOW()),
('Petén', 1, NOW(), NOW()),
('Izabal', 1, NOW(), NOW());


-- Insertar un departamento
CALL sp_departments_insert('Chimaltenango', 1);

-- Obtener todos los activos
CALL sp_departments_get_all();

-- Obtener por id
CALL sp_departments_get_by_id(1);

-- Actualizar un departamento
CALL sp_departments_update(2, 'Sacatepequez Modificado', 1);

-- Baja lógica
CALL sp_departments_delete(3);

-- Verificar cambios
CALL sp_departments_get_all();
