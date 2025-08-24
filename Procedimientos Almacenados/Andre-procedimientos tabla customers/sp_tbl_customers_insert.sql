-- Elimina el procedimiento si ya existe
DROP PROCEDURE IF EXISTS sp_tbl_customers_insert;

DELIMITER //

CREATE PROCEDURE sp_tbl_customers_insert (
    IN p_name VARCHAR(150),
    IN p_nit VARCHAR(20),
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_address TEXT,
    IN p_id_municipality INT
)
BEGIN
    INSERT INTO tbl_customers (name, nit, phone, email, address, id_municipality)
    VALUES (p_name, p_nit, p_phone, p_email, p_address, p_id_municipality);

    -- Devuelve el ID generado
    SELECT LAST_INSERT_ID() AS new_id;
END //

DELIMITER ;
