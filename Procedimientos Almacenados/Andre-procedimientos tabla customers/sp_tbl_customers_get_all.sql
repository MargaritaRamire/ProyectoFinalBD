-- Asegurarse de que no exista previamente
DROP PROCEDURE IF EXISTS sp_tbl_customers_get_all;

DELIMITER //

CREATE PROCEDURE sp_tbl_customers_get_all ()
BEGIN
    SELECT *
    FROM tbl_customers
    WHERE status = 1;  -- Solo clientes activos
END //

DELIMITER ;
