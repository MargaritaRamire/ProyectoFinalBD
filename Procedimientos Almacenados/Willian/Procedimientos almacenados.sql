DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_drivers_insert (
    IN p_name VARCHAR(100),
    IN p_license VARCHAR(50),
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_drivers (name, license, status, created_at, updated_at)
    VALUES (p_name, p_license, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_drivers_update (
    IN p_id_driver INT,
    IN p_name VARCHAR(100),
    IN p_license VARCHAR(50),
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_drivers
    SET name = p_name,
        license = p_license,
        status = p_status,
        updated_at = NOW()
    WHERE id_driver = p_id_driver;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_drivers_get_all ()
BEGIN
    SELECT id_driver, name, license, status, created_at, updated_at
    FROM tbl_drivers
    WHERE status = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_drivers_get_by_id (
    IN p_id_driver INT
)
BEGIN
    SELECT id_driver, name, license, status, created_at, updated_at
    FROM tbl_drivers
    WHERE id_driver = p_id_driver;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_drivers_delete (
    IN p_id_driver INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_drivers
    SET status = 0,
        updated_at = NOW()
    WHERE id_driver = p_id_driver;

    COMMIT;
END$$

DELIMITER ;
