

-- ============================================
-- INSERT
-- ============================================
DELIMITER $$
CREATE PROCEDURE sp_roles_insert (
    IN p_name_role VARCHAR(100),
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    INSERT INTO tbl_roles (name_role, status, created_at, updated_at)
    VALUES (p_name_role, p_status, NOW(), NOW());
    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_roles_update (
    IN p_id_role INT,
    IN p_name_role VARCHAR(100),
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    UPDATE tbl_roles
    SET name_role = p_name_role,
        status = p_status,
        updated_at = NOW()
    WHERE id_role = p_id_role;
    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_roles_get_all ()
BEGIN
    SELECT id_role, name_role, status, created_at, updated_at
    FROM tbl_roles
    WHERE status = 1;
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_roles_get_by_id (IN p_id_role INT)
BEGIN
    SELECT id_role, name_role, status, created_at, updated_at
    FROM tbl_roles
    WHERE id_role = p_id_role;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_roles_delete (IN p_id_role INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    UPDATE tbl_roles
    SET status = 0, updated_at = NOW()
    WHERE id_role = p_id_role;
    COMMIT;
END$$

DELIMITER ;

INSERT INTO tbl_roles (name_role, status, created_at, updated_at) VALUES
('Administrador', 1, NOW(), NOW()),
('Contador', 1, NOW(), NOW()),
('Conductor', 1, NOW(), NOW());

-- Relación usuario - rol
INSERT INTO tbl_roles_has_users (id_user, id_role) VALUES
(1, 1), -- Juan es Administrador
(2, 2), -- María es Contador
(3, 3); -- Carlos es Conductor

CALL sp_roles_insert('Administrador', 1);
CALL sp_roles_insert('Conductor', 1);
CALL sp_roles_get_all();
CALL sp_roles_update(2, 'Chofer', 1);
CALL sp_roles_get_by_id(1);
CALL sp_roles_delete(2);
