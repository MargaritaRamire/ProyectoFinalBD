DELIMITER //

CREATE PROCEDURE sp_delivery_assignments_delete (
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_id_driver INT
)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al eliminar la asignación' AS mensaje;
    END;

    START TRANSACTION;

    UPDATE tbl_delivery_assignments
    SET status = 0,
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
      AND id_driver = p_id_driver;
END //

DELIMITER ;

CALL sp_delivery_assignments_delete(1, 1, 1);