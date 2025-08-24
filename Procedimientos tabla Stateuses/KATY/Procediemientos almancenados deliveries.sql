DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_deliveries_insert (
    IN p_delivery_date DATE,
    IN p_delivery_status VARCHAR(50),
    IN p_id_route INT,
    IN p_id_status INT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_deliveries (delivery_date, delivery_status, id_route, id_status, status, created_at, updated_at)
    VALUES (p_delivery_date, p_delivery_status, p_id_route, p_id_status, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_deliveries_update (
    IN p_id_delivery INT,
    IN p_delivery_date DATE,
    IN p_delivery_status VARCHAR(50),
    IN p_id_route INT,
    IN p_id_status INT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_deliveries
    SET delivery_date = p_delivery_date,
        delivery_status = p_delivery_status,
        id_route = p_id_route,
        id_status = p_id_status,
        status = p_status,
        updated_at = NOW()
    WHERE id_delivery = p_id_delivery;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_deliveries_get_all ()
BEGIN
    SELECT id_delivery, delivery_date, delivery_status, id_route, id_status, status, created_at, updated_at
    FROM tbl_deliveries
    WHERE status = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_deliveries_get_by_id (
    IN p_id_delivery INT
)
BEGIN
    SELECT id_delivery, delivery_date, delivery_status, id_route, id_status, status, created_at, updated_at
    FROM tbl_deliveries
    WHERE id_delivery = p_id_delivery;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_deliveries_delete (
    IN p_id_delivery INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_deliveries
    SET status = 0,
        updated_at = NOW()
    WHERE id_delivery = p_id_delivery;

    COMMIT;
END$$

DELIMITER ;

