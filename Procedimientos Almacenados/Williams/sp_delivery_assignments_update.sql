DELIMITER //

CREATE PROCEDURE sp_delivery_assignments_update (
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_id_driver INT,
    IN p_assignment_date DATE
)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al actualizar asignación' AS mensaje;
    END;

    START TRANSACTION;

    UPDATE tbl_delivery_assignments
    SET 
        assignment_date = p_assignment_date,
        updated_at = NOW()
    WHERE id_delivery = p_id_delivery
      AND id_vehicle = p_id_vehicle
      AND id_driver = p_id_driver
      AND status = 1;

    COMMIT;

    SELECT *
    FROM tbl_delivery_assignments
    WHERE id_delivery = p_id_delivery
      AND id_vehicle = p_id_vehicle
      AND id_driver = p_id_driver
      AND status = 1;

END //

DELIMITER ;

CALL sp_delivery_assignments_update(1, 1, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY));