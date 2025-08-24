DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_incomes_insert (
    IN p_amount DECIMAL(10,2),
    IN p_description TEXT,
    IN p_income_date DATE,
    IN p_id_user INT,
    IN p_id_delivery INT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_incomes (amount, description, income_date, id_user, id_delivery, status, created_at, updated_at)
    VALUES (p_amount, p_description, p_income_date, p_id_user, p_id_delivery, p_status, NOW(), NOW());

    COMMIT;
END$$


-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_incomes_update (
    IN p_id_income INT,
    IN p_amount DECIMAL(10,2),
    IN p_description TEXT,
    IN p_income_date DATE,
    IN p_id_user INT,
    IN p_id_delivery INT,
    IN p_status BIT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_incomes
    SET amount = p_amount,
        description = p_description,
        income_date = p_income_date,
        id_user = p_id_user,
        id_delivery = p_id_delivery,
        status = p_status,
        updated_at = NOW()
    WHERE id_income = p_id_income;

    COMMIT;
END$$


-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_incomes_get_all ()
BEGIN
    SELECT i.id_income, i.amount, i.description, i.income_date,
           i.id_user, u.username AS user_name,
           i.id_delivery, d.delivery_date,
           i.status, i.created_at, i.updated_at
    FROM tbl_incomes i
    JOIN tbl_users u ON i.id_user = u.id_user
    LEFT JOIN tbl_deliveries d ON i.id_delivery = d.id_delivery
    WHERE i.status = 1;
END$$


-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_incomes_get_by_id (
    IN p_id_income INT
)
BEGIN
    SELECT i.id_income, i.amount, i.description, i.income_date,
           i.id_user, u.username AS user_name,
           i.id_delivery, d.delivery_date,
           i.status, i.created_at, i.updated_at
    FROM tbl_incomes i
    JOIN tbl_users u ON i.id_user = u.id_user
    LEFT JOIN tbl_deliveries d ON i.id_delivery = d.id_delivery
    WHERE i.id_income = p_id_income;
END$$


-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_incomes_delete (
    IN p_id_income INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_incomes
    SET status = 0,
        updated_at = NOW()
    WHERE id_income = p_id_income;

    COMMIT;
END$$

DELIMITER ;
