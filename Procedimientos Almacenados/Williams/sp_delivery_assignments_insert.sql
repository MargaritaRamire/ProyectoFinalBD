DELIMITER //

CREATE PROCEDURE sp_delivery_assignments_insert (
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_id_driver INT,
    IN p_assignment_date DATE
)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al registrar asignación' AS mensaje;
    END;

    START TRANSACTION;

    INSERT INTO tbl_delivery_assignments (
        id_delivery, id_vehicle, id_driver, assignment_date, status, created_at
    ) VALUES (
        p_id_delivery, p_id_vehicle, p_id_driver, p_assignment_date, 1, NOW()
    );

    COMMIT;
    
    SELECT *
    FROM tbl_delivery_assignments
    WHERE id_delivery = p_id_delivery
      AND id_vehicle = p_id_vehicle
      AND id_driver = p_id_driver
      AND status = 1;

END //

DELIMITER ;


CALL sp_delivery_assignments_insert(1, 1, 1, CURDATE());