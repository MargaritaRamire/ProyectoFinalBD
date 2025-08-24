-- Asegurarse de que no exista previamente
DROP PROCEDURE IF EXISTS sp_tbl_customers_delete;

DELIMITER //

CREATE PROCEDURE sp_tbl_customers_delete (IN p_id_customer INT)
BEGIN
    UPDATE tbl_customers
    SET status = 0,
        updated_at = NOW()
    WHERE id_customer = p_id_customer;
END //

DELIMITER ;
