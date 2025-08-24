DELIMITER //

CREATE PROCEDURE sp_delivery_assignments_get_all()
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al obtener las asignaciones' AS mensaje;
    END;

    START TRANSACTION;

    SELECT *
    FROM tbl_delivery_assignments
    WHERE status = 1;

    COMMIT;
END //

DELIMITER ;

CALL sp_delivery_assignments_get_all();