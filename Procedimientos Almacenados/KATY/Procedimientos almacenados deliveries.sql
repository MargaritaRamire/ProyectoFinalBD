USE logistics;

DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
DROP PROCEDURE IF EXISTS sp_delivery_statuses_insert$$
CREATE PROCEDURE sp_delivery_statuses_insert (
    IN p_name_status VARCHAR(50),
    IN p_description TEXT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_delivery_statuses (name_status, description, status, created_at, updated_at)
    VALUES (p_name_status, p_description, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
DROP PROCEDURE IF EXISTS sp_delivery_statuses_update$$
CREATE PROCEDURE sp_delivery_statuses_update (
    IN p_id_status INT,
    IN p_name_status VARCHAR(50),
    IN p_description TEXT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_delivery_statuses
    SET name_status = p_name_status,
        description = p_description,
        status = p_status,
        updated_at = NOW()
    WHERE id_status = p_id_status;

    COMMIT;
END$$

-- ============================================
-- GET ALL (solo activos)
-- ============================================
DROP PROCEDURE IF EXISTS sp_delivery_statuses_get_all$$
CREATE PROCEDURE sp_delivery_statuses_get_all ()
BEGIN
    SELECT id_status, name_status, description, status, created_at, updated_at
    FROM tbl_delivery_statuses
    WHERE status = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
DROP PROCEDURE IF EXISTS sp_delivery_statuses_get_by_id$$
CREATE PROCEDURE sp_delivery_statuses_get_by_id (
    IN p_id_status INT
)
BEGIN
    SELECT id_status, name_status, description, status, created_at, updated_at
    FROM tbl_delivery_statuses
    WHERE id_status = p_id_status;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
DROP PROCEDURE IF EXISTS sp_delivery_statuses_delete$$
CREATE PROCEDURE sp_delivery_statuses_delete (
    IN p_id_status INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_delivery_statuses
    SET status = 0,
        updated_at = NOW()
    WHERE id_status = p_id_status;

    COMMIT;
END$$

DELIMITER ;
