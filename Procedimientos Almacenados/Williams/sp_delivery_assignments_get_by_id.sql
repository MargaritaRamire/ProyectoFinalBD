DELIMITER //

CREATE PROCEDURE sp_delivery_assignments_get_by_id (
    IN p_id_delivery INT,
    IN p_id_vehicle INT,
    IN p_id_driver INT
)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al obtener la asignación' AS mensaje;
    END;

    START TRANSACTION;

    SELECT *
    FROM tbl_delivery_assignments
    WHERE id_delivery = p_id_delivery
      AND id_vehicle = p_id_vehicle
      AND id_driver = p_id_driver
      AND status = 1;

    COMMIT;
END //

DELIMITER ;

CALL sp_delivery_assignments_get_by_id(3, 1, 2);