-- ========================================
-- PROCEDURE: Obtener todos los tipos de gastos
-- ========================================
DROP PROCEDURE IF EXISTS sp_expense_types_get_all;
CREATE PROCEDURE sp_expense_types_get_all()
BEGIN
    SELECT id_expense_type, name, status, created_at, updated_at
    FROM tbl_expense_types;
END;

-- ========================================
-- PROCEDURE: Obtener un tipo de gasto por ID
-- ========================================
DROP PROCEDURE IF EXISTS sp_expense_types_get_by_id;
CREATE PROCEDURE sp_expense_types_get_by_id (
    IN p_id_expense_type INT
)
BEGIN
    SELECT id_expense_type, name, status, created_at, updated_at
    FROM tbl_expense_types
    WHERE id_expense_type = p_id_expense_type;
END;

-- ========================================
-- PROCEDURE: Insertar un nuevo tipo de gasto
-- ========================================
DROP PROCEDURE IF EXISTS sp_expense_types_insert;
CREATE PROCEDURE sp_expense_types_insert (
    IN p_name   VARCHAR(100),
    IN p_status TINYINT
)
BEGIN
    INSERT INTO tbl_expense_types (name, status, created_at, updated_at)
    VALUES (p_name, p_status, NOW(), NOW());
END;

-- ========================================
-- PROCEDURE: Actualizar un tipo de gasto
-- ========================================
DROP PROCEDURE IF EXISTS sp_expense_types_update;
CREATE PROCEDURE sp_expense_types_update (
    IN p_id_expense_type INT,
    IN p_name   VARCHAR(100),
    IN p_status TINYINT
)
BEGIN
    UPDATE tbl_expense_types
    SET name       = p_name,
        status     = p_status,
        updated_at = NOW()
    WHERE id_expense_type = p_id_expense_type;
END;

-- ========================================
-- PROCEDURE: Eliminar un tipo de gasto
-- ========================================
DROP PROCEDURE IF EXISTS sp_expense_types_delete;
CREATE PROCEDURE sp_expense_types_delete (
    IN p_id_expense_type INT
)
BEGIN
    DELETE FROM tbl_expense_types
    WHERE id_expense_type = p_id_expense_type;
END;
