-- Asegurarse de que no exista previamente
DROP PROCEDURE IF EXISTS sp_tbl_customers_get_by_id;

DELIMITER //

CREATE PROCEDURE sp_tbl_customers_get_by_id (IN p_id_customer INT)
BEGIN
    SELECT *
    FROM tbl_customers
    WHERE id_customer = p_id_customer;
END //

DELIMITER ;
