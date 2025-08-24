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
