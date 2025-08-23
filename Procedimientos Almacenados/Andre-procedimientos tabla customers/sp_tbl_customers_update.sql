-- Elimina el procedimiento si ya existe
DROP PROCEDURE IF EXISTS sp_tbl_customers_update;

DELIMITER //

CREATE PROCEDURE sp_tbl_customers_update (
    IN p_id_customer INT,
    IN p_name VARCHAR(150),
    IN p_nit VARCHAR(20),
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_address TEXT,
    IN p_id_municipality INT,
    IN p_status TINYINT
)
BEGIN
    UPDATE tbl_customers
    SET name = p_name,
        nit = p_nit,
        phone = p_phone,
        email = p_email,
        address = p_address,
        id_municipality = p_id_municipality,
        status = p_status,
        updated_at = NOW()
    WHERE id_customer = p_id_customer;
END //

DELIMITER ;
